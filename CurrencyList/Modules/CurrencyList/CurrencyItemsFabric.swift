//
//  CurrencyItemsFabric.swift
//  CurrencyList
//
//  Created by Alex Kosyakov on 23.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import Foundation

final class CurrencyItemsFabric {
    private var rates:[String : Float]?
    private var currencies:[String]?
    private var counts:[String : Float] = [:]
    
    private let privateConcurrentQueue = DispatchQueue(label: "com.CurrencyItemsFabric.", attributes: .concurrent)
    
    private var baseID:String?
    
    private var data:RatesResponse?
    
    func updateResponseData(data:RatesResponse, completion:(()->())) {
        
        defer {
            completion()
        }
        
        let initialResponse = itemsCount() == 0 && counts.count == 0
        
        if let newBaseID = data.baseID, initialResponse == true {
            rates = [newBaseID : 1]
            currencies = [newBaseID]
            counts = [newBaseID : 100]
            baseID = newBaseID
        }
        
        
        let newRates = data.rates
        newRates.forEach { (arg) in
            rates?[arg.key] = arg.value
        }
        
        guard let rates = rates, rates.count != currencies?.count else {
            return
        }
        
        let ratesKeys = Array(rates.keys)
        ratesKeys.forEach {
            let currencyExist = currencies?.contains($0) ?? false
            guard case currencyExist = false else {
               return
            }
            currencies?.append($0)
        }
    }
}

extension CurrencyItemsFabric {
    func itemsCount() -> Int {
        return currencies?.count ?? 0
    }
    
    func item(at index:Int, editMode: Bool) -> Currency? {
        guard let rates = rates, rates.count > 0, let currencies = currencies, index < currencies.count else {
            return nil
        }
        let itemID = currencies[index]
        let itemRate = rates[itemID] ?? 0
        
        var newItem = CurrencyItem()
        newItem.identifier = itemID
        newItem.rate = itemRate
        newItem.selected = (index == 0) && editMode
        
        guard case newItem.selected = false else {
            newItem.count = counts[itemID] ?? 0
            return newItem
        }
        
        let currentBaseID = editMode ? currencies.first : self.baseID
        
        let isBaseItem = itemID == currentBaseID
        let editCount = counts[currentBaseID!] ?? 0
        let editRate = rates[currentBaseID!] ?? 0
        
        
        guard editCount != 0 else {
            counts[itemID] = 0
            newItem.count = 0
            return newItem
        }
        
        let baseIDCount = Float(editCount/editRate)
        let newCount:Float = isBaseItem ? baseIDCount : Float(baseIDCount*itemRate)
        
        
        setItemCount(at: index, count: newCount)
        
        newItem.count = counts[itemID] ?? 0
        return newItem
    }
    
    func setItemCount(at index:Int, count: Float) {
        privateConcurrentQueue.async(flags: .barrier) {
            guard let currencies = self.currencies, index < currencies.count else {
                return
            }
            
            let itemID = currencies[index]
            self.counts[itemID] = count
        }
    }
}

extension CurrencyItemsFabric {
    func pushItemToTop(from index: Int) {
        guard var currencies = self.currencies, index < currencies.count else {
            return
        }
        let cID = currencies[index]
        currencies.remove(at: index)
        currencies.insert(cID, at: 0)
        self.currencies = currencies
    }
}
