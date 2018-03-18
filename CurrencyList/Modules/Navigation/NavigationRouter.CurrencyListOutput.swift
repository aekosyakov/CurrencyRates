//
//  NavigationRouter.CurrencyListOutput.swift
//  CurrencyList
//
//  Created by Alex Kosyakov on 18.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import Foundation

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
