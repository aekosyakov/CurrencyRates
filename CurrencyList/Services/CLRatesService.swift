//
//  RevolutApiService.swift
//  CurrencyList
//
//  Created by Alex Kosyakov on 22.02.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import UIKit
import Result
import Repeat

struct CurrencyItem: Currency {
    var count: Float?
    var identifier:String?
    var rate: Float?
    var selected: Bool = false
}

struct RatesResponse:CLResponseData {
    var rates:[String: Float] = [:]
    var baseID: String = "EUR"
    var currencies:[String] = []
    
    init(json: [String:Any]) {
        guard let rates  = json["rates"] as? [String: Float],
              let baseID = json["base"]  as? String else {
            return
        }
        self.rates = rates
        self.baseID = baseID
    }
}

extension CLRatesService {
    func startUpdateRates(every sec:Float, completion: @escaping ResultCompletion) {
        guard let timer = timer else {
            self.timer = Repeater.every(.seconds(Double(sec))) { _ in
                self.loadRates(completion)
            }
            return
        }
        timer.start()
    }
    
    func stopUpdateRates() {
        timer?.pause()
    }
}


class CLRatesService: CLRatesApi {
    let session = URLSession(configuration: .default)
    var task: URLSessionTask? = nil
    var timer: Repeater?
    
    func loadRates(_ completion: @escaping ResultCompletion) {
        guard let url = URL.init(string: "https://revolut.duckdns.org/latest?base=EUR") else {
            return;
        }

        task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                
                completion(.failure(.got(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.requestFailed))
                return
            }
            guard let json = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                completion(.failure(.requestFailed))
                return
            }

            completion(.success(RatesResponse(json: json)))
        }
        task?.resume()
        
    }
}
