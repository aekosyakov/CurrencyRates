//
//  CurrencyListProtocols.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 22.02.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import Foundation

// MARK: - Wireframe

protocol CurrencyListWireframeProtocol: class {

}

// MARK: - Presenter

protocol CurrencyListViewPresenter: class {
    func viewLoaded()
    func currencyItem(at index: Int) -> CurrencyItem?
    func numberOfItems() -> Int
    func didSelectCurrencyItem(at index: Int)
}

protocol CurrencyListInteractorPresenter: class {
    
}

typealias CurrencyListPresenterProtocol = CurrencyListViewPresenter & CurrencyListInteractorPresenter

// MARK: - Interactor

protocol CurrencyListInteractorProtocol: class {
    
}

// MARK: - View

protocol CurrencyListViewProtocol: class {
    var title: String? { set get }
}

// MARK: - IO

protocol CurrencyListInput: class {
    
}

protocol CurrencyListOutput: class {
    
}

protocol CurrencyListIO: CurrencyListInput {
    weak var output: CurrencyListOutput? { set get }
}
