//
//  NavigationRouter.Placeholder.swift
//  CurrencyList
//
//  Created by Alex Kosyakov on 18.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import Foundation

extension NavigationRouter {
    func showErrorPlaceholder(data: PlaceholderData) {
        do {
            if let vc = activeController(), vc.presentedViewController == nil {
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
    
    func hideError() {
        if let _ = errorVC {
            dismissFirstPresentedControllerIfPossible()
            self.errorVC = nil
        }
    }
}
