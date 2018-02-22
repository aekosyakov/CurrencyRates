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
}

extension CurrencyListPresenter: CurrencyListInteractorPresenter {
    
}

extension CurrencyListPresenter: CurrencyListIO {
    
}
