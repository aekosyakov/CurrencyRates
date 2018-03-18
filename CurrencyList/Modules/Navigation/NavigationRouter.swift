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
    
    private var errorVC: UIViewController?
    private var loaderVC: UIViewController?
    
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
    
    
    func showError(text: String) {
        if let _ = errorVC {
            return
        }
        
        do {
            if let vc = view?.viewControllers.first {
                let module = try ErrorPlaceholderRouter.createModule()
                module.input.errorText = text
                vc.navigationController?.present(customModalNavigationController(root: module.view), animated: false, completion: nil)
                self.errorVC = module.view
            }
        }
            
        catch let error {
            self.loaderVC = nil
            fatalError("\(#function): \(error)")
        }
    }
    
    func hideError() {
        if let _ = errorVC {
            dismissPresentedControllerIfPossible()
            self.errorVC = nil
        }
    }
    
    func showLoader() {
        
        if let _ = loaderVC {
            return
        }
        
        do {
            if let vc = view?.viewControllers.first {
                let module = try LoaderRouter.createModule()
                vc.navigationController?.present(customModalNavigationController(root: module.view), animated: false, completion: nil)
                self.loaderVC = module.view
            }
        }
        catch let error {
            self.loaderVC = nil
            fatalError("\(#function): \(error)")
        }
    }
    
    
    func hideLoader() {
        if let _ = loaderVC {
            dismissPresentedControllerIfPossible()
            self.loaderVC = nil
        }
    }
    
    private func dismissPresentedControllerIfPossible() {
        if let vc = view?.viewControllers.first, let presentedVC = vc.presentedViewController, let navController = vc.navigationController  {
            navController.dismiss(animated: false, completion: nil)
            DispatchQueue.main.async {
                presentedVC.view.runFade()
            }
        }
    }
    
    func showErrorPlaceholder(data: PlaceholderData) {
        do {
            if let vc = view?.viewControllers.first {
                let module = try ErrorPlaceholderRouter.createModule()
                module.input.errorText = data.text
                module.input.iconName = data.icon
                vc.navigationController?.present(customModalNavigationController(root: module.view), animated: false, completion: nil)
                self.errorVC = module.view
            }
        }
            
        catch let error {
            self.errorVC = nil
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


extension NavigationRouter : CurrencyListOutput {

    func showErrorPlaceholder(error: CurrencyError, input: CurrencyListInput) {
        switch error {
        case .connectionLost:
            showErrorPlaceholder(data: ("Connection lost", nil))
        case .got(let error):
            showErrorPlaceholder(data: (error.localizedDescription, nil))
        case .requestFailed:
            showErrorPlaceholder(data: ("Unable to finish request", nil))
        case .unknown:
            showErrorPlaceholder(data: ("Uknown error occured", nil))
        }
    }
    
    func hideErrorPlaceholder(input: CurrencyListInput) {
        hideError()
    }
    
    
    func showLoaderPlaceholder(input: CurrencyListInput) {
        showLoader()
    }
    
    func hideLoaderPlaceholder(input: CurrencyListInput) {
        hideLoader()
    }
}
