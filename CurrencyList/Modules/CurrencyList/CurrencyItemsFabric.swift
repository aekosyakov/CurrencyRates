//
//  CurrencyItemsFabric.swift
//  CurrencyList
//
//  Created by Alex Kosyakov on 23.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import Foundation

final class CurrencyItemsFabric {
    let storage:CurrencyStorage
    init(storage:CurrencyStorage) {
        self.storage = storage
    }
}

extension CurrencyItemsFabric {
    func itemsCount() -> Int {
        return storage.currencies.count
    }
    
    func item(at index:Int, editMode: Bool) -> Currency? {

        if index > storage.currencies.count {
            return nil
        }
        
        
        let itemID = storage.currencies[index]
        
        let itemRate = storage.rates[itemID] ?? 0
        
        var newItem = CurrencyItem()
        newItem.identifier = itemID
        newItem.rate = itemRate
        newItem.selected = (index == 0) && editMode
        
        guard case newItem.selected = false else {
            newItem.count = storage.counts[itemID] ?? 0
            return newItem
        }
        
        let currentBaseID = editMode ? storage.currencies.first : storage.baseID
        
        let isBaseItem = itemID == currentBaseID
        
        
        
        let editCount = storage.counts[currentBaseID!]
        let editRate  = storage.rates[currentBaseID!]
        
        
        guard editCount != 0 else {
            storage.setItemCount(for: itemID, count: 0)
            newItem.count = 0
            return newItem
        }
        
        let baseIDCount = Float(editCount!/editRate!)
        let newCount:Float = isBaseItem ? baseIDCount : Float(baseIDCount*itemRate)
        
        
        storage.setItemCount(for: itemID, count: newCount)
        newItem.count = storage.counts[itemID] ?? 0
        
        return newItem
    }
    
    
    private func itemCount(for itemID:String) -> Float {
        return storage.counts[itemID] ?? 0
    }
}

extension CurrencyItemsFabric {
    func setItemCount(at index:Int, count:Float) {
        if let itemID = storage.itemID(for: index) {
            storage.setItemCount(for: itemID, count: count)
        }
    }
    
    func pushItemToTop(from index: Int) {
        if let itemID = storage.itemID(for: index) {
            storage.move(itemID, toIndex: 0)
        }
    }
}
