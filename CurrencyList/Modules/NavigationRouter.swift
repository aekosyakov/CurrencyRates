//
//  NavigationRouter.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 22.02.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import UIKit

final class NavigationRouter: NavigationWireframeProtocol {
    
    fileprivate weak var view: (UIViewController & NavigationViewProtocol)?
    
    static func createModule(output: NavigationOutput? = nil) throws -> ViperModule<UIViewController, NavigationIO> {
        let view = NavigationViewController(nibName: nil, bundle: nil)
        let interactor = NavigationInteractor()
        let router = NavigationRouter()
        let presenter = NavigationPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        presenter.output = output
        
        return ViperModule(view: view, input: presenter)
    }
}
