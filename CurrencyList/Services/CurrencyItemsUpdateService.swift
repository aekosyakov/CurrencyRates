//
//  CurrencyItemsUpdateService.swift
//  CurrencyList
//
//  Created by Alex Kosyakov on 18.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import UIKit
import Repeat

class CurrencyItemsUpdateService: CurrencyUpdateAPI {
    var timer: Repeater?
    var fetchService: CurrencyRatesAPI
    required init(fetchService:CurrencyRatesAPI) {
        self.fetchService = fetchService
    }

    func startUpdateRates(every sec:Float, completion: @escaping ResultCompletion) {
        guard let timer = timer else {
            self.timer = Repeater.every(.seconds(Double(sec))) { [weak self] _ in
                self?.loadRates(completion)
            }
            return
        }
        timer.start()
    }
    
    func stopUpdateRates() {
        timer?.pause()
    }
    
    func currentBaseID() -> String {
        return CurrencyIDs.eur
    }
    
    private func loadRates(_ completion: @escaping ResultCompletion) {
        fetchService.loadRates(base: currentBaseID(), completion: completion)
    }
    

}
