//
//  CurrencyitemProtocols.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 01.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import Foundation

// MARK: - Wireframe

protocol CurrencyitemWireframeProtocol: class {

}

// MARK: - Presenter

protocol CurrencyitemViewPresenter: class {
    
}

protocol CurrencyitemInteractorPresenter: class {
    
}

typealias CurrencyitemPresenterProtocol = CurrencyitemViewPresenter & CurrencyitemInteractorPresenter

// MARK: - Interactor

protocol CurrencyitemInteractorProtocol: class {
    
}

// MARK: - View

protocol CurrencyitemViewProtocol: class {
    
}

// MARK: - IO

protocol CurrencyitemInput: class {
    func item() throws -> CurrencyItem
    func setItem(_ item: CurrencyItem?)
}

protocol CurrencyitemOutput: class {

}

protocol CurrencyitemIO: CurrencyitemInput {
    weak var output: CurrencyitemOutput? { set get }
}
