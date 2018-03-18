//
//  LoaderPresenter.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 17.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import UIKit

final class LoaderPresenter {

    fileprivate weak var view: LoaderViewProtocol!
    fileprivate let interactor: LoaderInteractorProtocol
    fileprivate let router: LoaderWireframeProtocol
    
    weak var output: LoaderOutput?

    init(view: LoaderViewProtocol, interactor: LoaderInteractorProtocol, router: LoaderWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension LoaderPresenter: LoaderViewPresenter {
    func viewLoaded() {
        
    }
}

extension LoaderPresenter: LoaderInteractorPresenter {
    
}

extension LoaderPresenter: LoaderIO {
    
}
