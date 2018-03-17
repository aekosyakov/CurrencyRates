//
//  RevolutApiService.swift
//  CurrencyList
//
//  Created by Alex Kosyakov on 22.02.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import UIKit
import enum Result.Result
import Repeat


protocol JSONParsing {
    func stringValue(for key: String) -> String
}

struct CurrencyItem: Currency {
    var count: Float?
    var identifier:String?
    var rate: Float?
    var selected: Bool = false
}

struct RatesData:RatesResponse {
    var rates:[String: Float] = [:]
    var baseID: String = "EUR"
    var currencies:[String] = []
    
    init(json: [String:Any]) {
        
        guard let rates = json["rates"] as? [String: Float], let baseID = json["base"] as? String else {
            return
        }
        self.rates = rates
        self.baseID = baseID
//
//
//
//        if self.currencies.count != self.rates.count {
//            Array(self.rates.keys).forEach({ (string) in
//                if self.currencies.contains(string) == false {
//                    self.currencies.append(string)
//                }
//            })
//        }
    }
}

extension CurrencyService {
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

class CurrencyService: CurrencyRatesAPI {
    let session = URLSession(configuration: .default)
    var task: URLSessionTask? = nil
    var timer: Repeater?
    
    func loadRates(_ completion: @escaping ResultCompletion) {
        guard let url = URL.init(string: "https://revolut.duckdns.org/latest?base=EUR") else {
            return;
        }

        task = session.dataTask(with: url) { data, response, error in
            print("data received")
            
            if let _ = error {
                completion(.failure(.failedToComplete))
                return
            }
            
            guard let data = data else {
                completion(.failure(.failedToComplete))
                return
            }
            guard let json = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                completion(.failure(.failedToParseResponse))
                return
            }

            completion(.success(RatesData(json: json)))
        }
        task?.resume()
        
    }
}
