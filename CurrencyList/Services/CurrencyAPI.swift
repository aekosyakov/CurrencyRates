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
}

public enum CurrencyError: Error {
    case failedToComplete
}

public protocol CurrencyRates {
    func loadRates(_ completion: @escaping (Result <[Currency], CurrencyError>) -> Void)
}
