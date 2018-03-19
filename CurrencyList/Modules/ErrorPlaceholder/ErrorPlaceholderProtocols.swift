//
//  ErrorPlaceholderProtocols.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 18.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import Foundation
import UIKit.UIImage

// MARK: - Wireframe

protocol ErrorPlaceholderWireframeProtocol: ErrorPlaceholderInput {

}

// MARK: - Presenter

protocol ErrorPlaceholderViewPresenter: class {
    func viewLoaded()
}

protocol ErrorPlaceholderInteractorPresenter: class {
    
}

typealias ErrorPlaceholderPresenterProtocol = ErrorPlaceholderViewPresenter & ErrorPlaceholderInteractorPresenter

// MARK: - Interactor

protocol ErrorPlaceholderInteractorProtocol: class {
    
}

// MARK: - View

protocol ErrorPlaceholderViewProtocol: class {
    var title: String? { set get }
    func setErrorText(_ text:String)
    func setIcon(_ image: UIImage?)
}

// MARK: - IO

protocol ErrorPlaceholderInput: class {
    var errorText: String? { set get }
    var iconName:String? { set get }
}

protocol ErrorPlaceholderOutput: class {
}

protocol ErrorPlaceholderIO: ErrorPlaceholderInput {
    weak var output: ErrorPlaceholderOutput? { set get }
}
