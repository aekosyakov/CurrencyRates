//
//  RevolutApiService.swift
//  CurrencyList
//
//  Created by Alex Kosyakov on 22.02.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import UIKit
import Result

struct CurrencyItem: Currency {
    var count: Float?
    var identifier:String?
    var rate: Float?
    var selected: Bool = false
}

struct CurrencyResponse:RatesResponse {
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


class CurrencyItemsFetchService: CurrencyRatesAPI {
    let session = URLSession(configuration: .default)
    var task: URLSessionTask? = nil
    
    
    private enum URLConsts {
        static let revolutURL = "https://revolut.duckdns.org/latest"
    }
    
    func loadRates(base currency:String, completion: @escaping ResultCompletion) {
        guard let url = URL.init(string: URLConsts.revolutURL + "?base=\(currency)") else {
            completion(.failure(.requestFailed))
            return
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
            
            completion(.success(CurrencyResponse(json: json)))
        }
        task?.resume()
    }

}

