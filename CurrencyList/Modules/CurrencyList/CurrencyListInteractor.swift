//
//  CurrencyListInteractor.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 22.02.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import UIKit

final class CurrencyListInteractor: CurrencyListInteractorProtocol {
    weak var presenter: CurrencyListInteractorPresenter?
    
    private var currencyService: CurrencyRatesAPI
    
    
    private var rates:[String : Float] = [:]
    private var currencies:[String] = []
    private var counts:[String : Float] = [:]
    private var baseID = "EUR"
    
    init(currencyService: CurrencyRatesAPI) {
        self.currencyService = currencyService
    }
    
    
    var itemsCount:Int {
        return currencies.count
    }
    
    func currencyItem(at index:Int, editMode: Bool) -> Currency? {
        guard rates.count > 0 , index < currencies.count else {
            return nil
        }
        let itemID = currencies[index]
        let itemRate = rates[itemID] ?? 0
        
        var currencyItem = CurrencyItem()
        currencyItem.identifier = itemID
        currencyItem.rate = itemRate
        
        currencyItem.selected = (index == 0) && editMode
        
        let currentBaseID = editMode ? currencies.first : self.baseID
        let editCount = counts[currentBaseID!] ?? 0
        let editRate = rates[currentBaseID!] ?? 0
        
        
        guard editCount != 0 else {
            counts[itemID] = 0
            currencyItem.count = 0
            return currencyItem
        }
        
        let baseIDCount = Float(editCount/editRate)
        print("edit count \(editCount), editRate \(editRate)")
        
        var newCount:Float = 0
        if index == 0 {
            newCount = counts[itemID] ?? 0
        } else {
            if itemID == currentBaseID {
                newCount = baseIDCount
                
            } else {
                newCount = Float(baseIDCount*itemRate)
            }
        }
        counts[itemID] = newCount
        
        currencyItem.count = counts[itemID] ?? 0
        
        
        return currencyItem
    }
    
    func editSelectedItemCount(_ count: Float) {
        guard let itemID = self.currencies.first else {
            return
        }
        counts[itemID] = count
    }
    
    func updateCurrencyItems(_ completion:@escaping ((NSError?)-> ())) {
        currencyService.startUpdateRates(every: 1) { (result) in
            switch result {
            case .success(let ratesData):
                self.rates = ratesData.rates
                self.baseID = ratesData.baseID
                
                Array(self.rates.keys).forEach({ (string) in
                    if self.currencies.contains(string) == false {
                        self.currencies.append(string)
                    }
                })
                
                if self.counts.keys.contains(self.baseID) == false {
                    self.counts[self.baseID] = 100
                }
                
                if self.rates.keys.contains(self.baseID) == false {
                    self.rates[self.baseID] = 1
                }
                
                if self.currencies.contains(self.baseID) == false {
                    self.currencies.insert(self.baseID, at: 0)
                }
                
                completion(nil)
            case .failure(let error):
                completion(error as NSError)
            }
        }
    }
    
    func stopUpdatingCurrencyItems() {
        currencyService.stopUpdateRates()
    }
    
    func addCurrencyItemToTop(from index: Int) {
        let item = self.currencies[index]
        currencies.remove(at: index)
        currencies.insert(item, at: 0)
    }
}
