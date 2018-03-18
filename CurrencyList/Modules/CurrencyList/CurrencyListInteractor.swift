//
//  CurrencyListInteractor.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 22.02.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import UIKit
import Result
import Reachability

final class CurrencyListInteractor: CurrencyListInteractorProtocol {    
    weak var presenter: CurrencyListInteractorPresenter?
    
    private var updateService: CurrencyUpdateAPI
    private var baseID = "EUR"
    
    private var rates:[String : Float] = [:]
    private var currencies:[String] = []
    private var counts:[String : Float] = [:]
    
    fileprivate let reachability = Reachability()!

    init(updateService: CurrencyUpdateAPI) {
        self.updateService = updateService
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
        
        var newItem = CurrencyItem()
        newItem.identifier = itemID
        newItem.rate = itemRate
        
        newItem.selected = (index == 0) && editMode
        
        let currentBaseID = editMode ? currencies.first : self.baseID
        let editCount = counts[currentBaseID!] ?? 0
        let editRate = rates[currentBaseID!] ?? 0
        
        
        guard editCount != 0 else {
            counts[itemID] = 0
            newItem.count = 0
            return newItem
        }
        
        let baseIDCount = Float(editCount/editRate)        
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
        newItem.count = counts[itemID] ?? 0
        return newItem
    }
    
    func editSelectedItemCount(_ count: Float) {
        guard let itemID = self.currencies.first else {
            return
        }
        counts[itemID] = count
    }
    
    func updateCurrencyItems(_ completion:@escaping ((CurrencyError?)-> ())) {
        updateService.startUpdateRates(every: 1) { (result) in
            switch result {
            case .success(let data):
                self.handleResponse(data, completion: {
                    completion(nil)
                })
            case .failure(let error):
                switch self.reachability.connection {
                case .none:
                    completion(.connectionLost)
                    return
                default:
                    break
                }
                completion(error)
            }
        }
    }
    
    func stopUpdatingCurrencyItems() {
        updateService.stopUpdateRates()
    }
    
    func addCurrencyItemToTop(from index: Int) {
        let item = self.currencies[index]
        currencies.remove(at: index)
        currencies.insert(item, at: 0)
    }
}


extension CurrencyListInteractor {
    func handleResponse(_ data:RatesResponse, completion:(()->())) {
        
        let initialResponse = rates.count == 0
        
        rates = data.rates
        baseID = data.baseID
        
        Array(rates.keys).forEach({ (string) in
            if currencies.contains(string) == false {
                currencies.append(string)
            }
        })
        
        if counts.keys.contains(baseID) == false {
            counts[baseID] = 100
        }
        
        if rates.keys.contains(baseID) == false {
            rates[baseID] = 1
        }
        
        if currencies.contains(baseID) == false {
            currencies.insert(baseID, at: 0)
        }
        
        if (initialResponse) {
            presenter?.hideLoader()
        }
        
        completion()
    }
}
