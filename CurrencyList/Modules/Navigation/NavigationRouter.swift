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
    
    fileprivate weak var view: (UINavigationController & NavigationViewProtocol)?
    
    static func createModule(output: NavigationOutput? = nil) throws -> ViperModule<UINavigationController, NavigationIO> {
        let view = NavigationViewController()
        let interactor = NavigationInteractor()
        let router = NavigationRouter()
        let presenter = NavigationPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        presenter.output = output
        
        return ViperModule(view: view, input: presenter)
    }
    
    func showCurrencyList() {
        do  {
            let module = try CurrencyListRouter.createModule()
            view?.setViewControllers([module.view], animated:false)
        }
        catch let error {
             print("\(#function): \(error)")
        }
    }
}
