//
//  NavigationProtocols.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 22.02.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import Foundation

// MARK: - Wireframe

protocol NavigationWireframeProtocol: NavigationInput {

}

// MARK: - Presenter

protocol NavigationViewPresenter: class {
    func viewLoaded()
}

protocol NavigationInteractorPresenter: class {
    
}

typealias NavigationPresenterProtocol = NavigationViewPresenter & NavigationInteractorPresenter

// MARK: - Interactor

protocol NavigationInteractorProtocol: class {
    
}

// MARK: - View

protocol NavigationViewProtocol: class {
    var title: String? { set get }
}

// MARK: - IO

protocol NavigationInput: class {
    func showCurrencyList()
}

protocol NavigationOutput: class {
    
}

protocol NavigationIO: NavigationInput {
    weak var output: NavigationOutput? { set get }
}
