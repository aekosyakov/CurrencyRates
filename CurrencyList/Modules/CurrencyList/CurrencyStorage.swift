//
//  CurrencyStorage.swift
//  CurrencyList
//
//  Created by Alex Kosyakov on 24.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import Foundation

final class CurrencyStorage {
    typealias JSONDictionary = [String : Float]
    
    private let concurrenQueue = DispatchQueue(label: "com.currencystorage.custom.queue", attributes: .concurrent)
    
    private var innerRates:JSONDictionary = [:]
    private var innerCurrencies:[String] = []
    private var innerCounts:JSONDictionary = [:]
    private var innerBaseID:String?
}

extension CurrencyStorage {
    public var rates:JSONDictionary {
        var ratesCopy:JSONDictionary!
        concurrenQueue.sync {
            ratesCopy = self.innerRates
        }
        return ratesCopy
    }
    
    public var currencies:[String] {
        var currenciesCopy:[String]!
        concurrenQueue.sync {
            currenciesCopy = self.innerCurrencies
        }
        return currenciesCopy
    }
    
    public var counts:JSONDictionary {
        var countsCopy:JSONDictionary!
        concurrenQueue.sync {
            countsCopy = self.innerCounts
        }
        return countsCopy
    }
    
    public var baseID:String {
        return innerBaseID ?? ""
    }
    
    public var isEmpty:Bool {
        return rates.count == 0 || currencies.count == 0 || counts.count == 0
    }
}

extension CurrencyStorage {
    public func move(_ itemID:String, toIndex:Int) {
        var currenciesToUpdate = self.currencies
        let itemIDEXist = currenciesToUpdate.contains(itemID)
        
        if itemIDEXist == false {
            return
        }
        
        guard let exIndex = currenciesToUpdate.index(of: itemID), exIndex != toIndex else {
            return
        }
        
        currenciesToUpdate.remove(at: exIndex)
        currenciesToUpdate.insert(itemID, at: toIndex)
        
        concurrenQueue.async(flags: .barrier) {
            self.innerCurrencies = currenciesToUpdate
        }
    }
    
    public func setItemCount(for itemID:String, count: Float) {
        concurrenQueue.async(flags: .barrier) {
            self.innerCounts[itemID] = count
        }
    }
    
    public func itemID(for index:Int) -> String? {
        if index >= currencies.count {
            return nil
        }
        
        return currencies[index]
    }
    
    public func update(with data:RatesResponse, completion:(()->())) {
        defer {
            completion()
        }
        
        if let newBaseID = data.baseID, self.isEmpty == true {
            self.innerRates      = [newBaseID : 1]
            self.innerCurrencies = [newBaseID]
            self.innerCounts     = [newBaseID : 100]
            self.innerBaseID     = newBaseID
        }
        
        
        let newRates = data.rates
        var updatedRates:JSONDictionary = self.rates
        newRates.forEach { (arg) in
            updatedRates[arg.key] = arg.value
        }
        
        concurrenQueue.async(flags: .barrier) {
            self.innerRates = updatedRates
        }
        
        
        
        let newCurrencies = Array(rates.keys)
        var updatedCurrencies = self.currencies
        newCurrencies.forEach {
            let currencyExist = updatedCurrencies.contains($0)
            guard case currencyExist = false else {
                return
            }
            updatedCurrencies.append($0)
        }
        
        concurrenQueue.async(flags: .barrier) {
            self.innerCurrencies = updatedCurrencies
        }
       
    }
}

