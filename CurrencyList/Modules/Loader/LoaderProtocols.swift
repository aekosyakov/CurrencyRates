//
//  LoaderProtocols.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 17.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import Foundation

// MARK: - Wireframe

protocol LoaderWireframeProtocol: class {

}

// MARK: - Presenter

protocol LoaderViewPresenter: class {
    func viewLoaded()
}

protocol LoaderInteractorPresenter: class {
    
}

typealias LoaderPresenterProtocol = LoaderViewPresenter & LoaderInteractorPresenter

// MARK: - Interactor

protocol LoaderInteractorProtocol: class {
    
}

// MARK: - View

protocol LoaderViewProtocol: class {
}

// MARK: - IO

protocol LoaderInput: class {
    
}

protocol LoaderOutput: class {
    
}

protocol LoaderIO: LoaderInput {
    weak var output: LoaderOutput? { set get }
}
