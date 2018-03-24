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
    internal var itemsFabric: CurrencyItemsFabric
    weak var presenter: CurrencyListInteractorPresenter?
    
    private var updateService: CurrencyUpdateAPI
    
    fileprivate let reachability = Reachability()!

    init(updateService: CurrencyUpdateAPI, itemsFabric:CurrencyItemsFabric) {
        self.updateService = updateService
        self.itemsFabric = itemsFabric
    }
}

extension CurrencyListInteractor {
    func updateCurrencyItems(_ completion:@escaping ((CurrencyError?)-> ())) {
        updateService.startUpdateRates(every: 1) {[weak self] (result) in
            switch result {
            case .success(let data):
                self?.handleResponse(data, completion: {
                    completion(nil)
                })
            case .failure(let error):
                switch self?.reachability.connection {
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
}

extension CurrencyListInteractor {
    func handleResponse(_ data:RatesResponse, completion:@escaping (()->())) {
        
        let initialResponse = itemsFabric.storage.isEmpty
        
        itemsFabric.storage.update(with: data) {
            completion()
            
            if (initialResponse) {
                self.presenter?.hideLoader()
            }
        }

        
    }
}
