//
//  NavigationRouter.Loader.swift
//  CurrencyList
//
//  Created by Alex Kosyakov on 18.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import Foundation

extension NavigationRouter {
    func showLoader() {
        if let _ = loaderVC {
            return
        }
        do {
            if let vc = activeController(), vc.presentedViewController == nil {
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
            dismissFirstPresentedControllerIfPossible()
            loaderVC = nil
        }
    }
}
