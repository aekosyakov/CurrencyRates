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
    case unknown, connectionLost, requestFailed, got(Error)
}

public protocol CLResponseData {
    var rates:[String: Float] { get }
    var baseID: String { get }
    var currencies:[String] { get }
    
    init(json:[String : Any])
}


public typealias ResultCompletion = (Result <CLResponseData, CurrencyError>) -> Void

public protocol CLRatesApi: class {
    func startUpdateRates(every sec:Float, completion: @escaping ResultCompletion)
    func stopUpdateRates()
}
