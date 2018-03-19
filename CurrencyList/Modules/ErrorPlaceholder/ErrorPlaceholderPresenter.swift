//
//  ErrorPlaceholderPresenter.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 18.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import UIKit

final class ErrorPlaceholderPresenter {

    fileprivate weak var view: ErrorPlaceholderViewProtocol!
    fileprivate let interactor: ErrorPlaceholderInteractorProtocol
    fileprivate let router: ErrorPlaceholderWireframeProtocol
    
    weak var output: ErrorPlaceholderOutput?

    init(view: ErrorPlaceholderViewProtocol, interactor: ErrorPlaceholderInteractorProtocol, router: ErrorPlaceholderWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension ErrorPlaceholderPresenter: ErrorPlaceholderViewPresenter {
    func viewLoaded() {
        
        view?.title = "Error"
        view.setErrorText(self.errorText ?? "Some error occured")
        
        if let iconName = self.iconName, let image = UIImage(named:iconName) {
            view.setIcon(image)
        }
    }
}

extension ErrorPlaceholderPresenter: ErrorPlaceholderInteractorPresenter {
    
}

extension ErrorPlaceholderPresenter: ErrorPlaceholderIO {
    var iconName: String? {
        get {
            return router.iconName
        }
        set {
            router.iconName = newValue
        }
    }
    
    var errorText: String? {
        get {
            return router.errorText
        }
        set {
            router.errorText = newValue
        }
    }
    
    
}
