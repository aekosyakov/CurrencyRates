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
    var rate: Float? { get set }
    var count: Float? { get set }
    var selected: Bool { get set }
}

public enum CurrencyError: Error {
    case failedToComplete
    case failedToParseResponse
}

public protocol RatesResponse {
    var rates:[String: Float] { get }
    var baseID: String { get }
    var currencies:[String] { get }
    
    init(json:[String : Any])
}


public typealias ResultCompletion = (Result <RatesResponse, CurrencyError>) -> Void

public protocol CurrencyRatesAPI: class {
    func startUpdateRates(every sec:Float, completion: @escaping ResultCompletion)
    func stopUpdateRates()
}
