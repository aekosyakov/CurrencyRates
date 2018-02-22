//
//  CurrencyRatesService.swift
//  CurrencyList
//
//  Created by Alex Kosyakov on 22.02.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import Foundation

public struct Currency {
    public let identifier:String
    public let rate: Float
    
}

public enum CurrencyRatesError: Error {
    case failedToComplete
}

public protocol CurrencyRatesService {
    func loadRates(_ completion: @escaping (Result <[Currency], CurrencyRatesError>) -> Void)
}
