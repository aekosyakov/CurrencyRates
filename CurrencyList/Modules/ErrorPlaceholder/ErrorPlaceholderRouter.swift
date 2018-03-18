//
//  ErrorPlaceholderRouter.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 18.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import UIKit

final class ErrorPlaceholderRouter: ErrorPlaceholderWireframeProtocol {
    
    fileprivate weak var view: (UIViewController & ErrorPlaceholderViewProtocol)?
    
    var errorText: String?
    var iconName: String?
    
    static func createModule(output: ErrorPlaceholderOutput? = nil) throws -> ViperModule<UIViewController, ErrorPlaceholderIO> {
        let view = ErrorPlaceholderViewController(nibName: nil, bundle: nil)
        let interactor = ErrorPlaceholderInteractor()
        let router = ErrorPlaceholderRouter()
        let presenter = ErrorPlaceholderPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        presenter.output = output
        
        return ViperModule(view: view, input: presenter)
    }
}
