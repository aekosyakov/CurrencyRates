//
//  CurrencyRatesService.swift
//  CurrencyList
//
//  Created by Alex Kosyakov on 22.02.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import Foundation
import Result

public protocol Currency {
    var identifier:String? { get set }
    var rate: Float?  { get set }
    var count: Float? { get set }
    var selected: Bool { get set }
}

public enum CurrencyError: Error {
    case unknown, connectionLost, requestFailed, got(Error)
}

public enum CurrencyIDs {
    static let eur = "EUR"
    static let usd = "USD"
    static let rub = "RUB"
}

public protocol RatesResponse {
    var rates:[String: Float] { get }
    var baseID: String? { get }
    var currencies:[String] { get }
    
    
    init(json:[String : Any])
    func isValid() -> Bool
}


public typealias ResultCompletion = (Result <RatesResponse, CurrencyError>) -> Void

public protocol CurrencyRatesAPI: class {
    func loadRates(base currency:String, completion: @escaping ResultCompletion)
}

public protocol CurrencyUpdateAPI: class {
    init(fetchService:CurrencyRatesAPI)
    func startUpdateRates(every sec:Float, completion: @escaping ResultCompletion)
    func stopUpdateRates()
    func currentBaseID() -> String 
}
