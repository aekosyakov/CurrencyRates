//
//  NavigationPresenter.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 22.02.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import UIKit

final class NavigationPresenter {

    fileprivate weak var view: NavigationViewProtocol!
    fileprivate let interactor: NavigationInteractorProtocol
    fileprivate let router: NavigationWireframeProtocol
    
    weak var output: NavigationOutput?

    init(view: NavigationViewProtocol, interactor: NavigationInteractorProtocol, router: NavigationWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension NavigationPresenter: NavigationViewPresenter {
    func viewLoaded() {
        view?.title = "Navigation"
    }
}

extension NavigationPresenter: NavigationInteractorPresenter {
    
}

extension NavigationPresenter: NavigationIO {
    
    func showCurrencyList() {
        router.showCurrencyList()
    }
}
