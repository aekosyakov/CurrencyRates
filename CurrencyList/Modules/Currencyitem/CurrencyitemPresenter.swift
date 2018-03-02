//
//  CurrencyitemPresenter.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 01.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import UIKit

final class CurrencyitemPresenter {

    fileprivate weak var view: CurrencyitemViewProtocol!
    fileprivate let interactor: CurrencyitemInteractorProtocol
    fileprivate let router: CurrencyitemWireframeProtocol
    
    weak var output: CurrencyitemOutput?

    init(view: CurrencyitemViewProtocol, interactor: CurrencyitemInteractorProtocol, router: CurrencyitemWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension CurrencyitemPresenter: CurrencyitemViewPresenter {
    
}

extension CurrencyitemPresenter: CurrencyitemInteractorPresenter {
    
}

extension CurrencyitemPresenter: CurrencyitemIO {
    
}
