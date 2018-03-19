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
    
    var errorVC: UIViewController?
    var loaderVC: UIViewController?
    
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
    
    func activeController() -> UIViewController? {
        return view?.viewControllers.first
    }
}

extension NavigationRouter {
    func showCurrencyList() {
        do  {
            let module = try CurrencyListRouter.createModule(output: self)
            view?.setViewControllers([module.view], animated:false)
        }
        catch let error {
            fatalError("\(#function): \(error)")
        }
    }
}

extension NavigationRouter {
    func customModalNavigationController(root: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: root)
        nav.navigationBar.useCustomStyle()
        nav.modalPresentationStyle = .overFullScreen
        return nav
    }
}

extension NavigationRouter {
    func dismissFirstPresentedControllerIfPossible() {
        if let vc = view?.viewControllers.first, let presentedVC = vc.presentedViewController, let navController = vc.navigationController  {
            DispatchQueue.main.async {
                presentedVC.view.runFade()
                navController.dismiss(animated: false, completion: nil)
            }
        }
    }
}
