//
//  CurrencyListPresenter.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 22.02.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import UIKit

final class CurrencyListPresenter {

    fileprivate weak var view: CurrencyListViewProtocol!
    fileprivate let interactor: CurrencyListInteractorProtocol
    fileprivate let router: CurrencyListWireframeProtocol
    
    weak var output: CurrencyListOutput?
    
    var currencies:[CurrencyItem] = []
    
    init(view: CurrencyListViewProtocol, interactor: CurrencyListInteractorProtocol, router: CurrencyListWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension CurrencyListPresenter: CurrencyListViewPresenter {
    func viewLoaded() {
        view?.title = "CurrencyList"
    }
    
    func currencyItem(at index: Int) -> CurrencyItem? {
        let currencyItem = CurrencyItem()
        currencyItem.rate = 1.23
        currencyItem.identifier = "EUR"
        return currencyItem
    }
    
    func didSelectCurrencyItem(at index: Int) {
        
    }
    
    func numberOfItems() -> Int {
        return 3
    }
}

extension CurrencyListPresenter: CurrencyListInteractorPresenter {
    
}

extension CurrencyListPresenter: CurrencyListIO {
    
}
