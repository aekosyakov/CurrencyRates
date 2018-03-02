//
//  RevolutApiService.swift
//  CurrencyList
//
//  Created by Alex Kosyakov on 22.02.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import UIKit
import Result


class CurrencyService: CurrencyRates {
    let session = URLSession(configuration: .default)
    var task: URLSessionTask? = nil
    
    func loadRates(_ completion: @escaping (Result <[Currency], CurrencyError>) -> Void) {
        guard let url = URL.init(string: "sdfsdf") else {
            return;
        }
        task = session.dataTask(with: url) { data, response, error in
            print("data")
            
            if let error = error {
                
            }
        }
        task?.resume()}
}
