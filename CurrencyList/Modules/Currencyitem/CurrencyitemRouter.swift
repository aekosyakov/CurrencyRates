//
//  CurrencyitemRouter.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 01.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import UIKit

final class CurrencyitemRouter: CurrencyitemWireframeProtocol {
    
    fileprivate weak var view: (UIView & CurrencyitemViewProtocol)?
    
    static func createModule(output: CurrencyitemOutput? = nil) throws -> ViperModule<UIView, CurrencyitemIO> {
        let view: CurrencyitemView = try .instantiateFromXib()
        let interactor = CurrencyitemInteractor()
        let router = CurrencyitemRouter()
        let presenter = CurrencyitemPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        presenter.output = output
        
        return ViperModule(view: view, input: presenter)
    }
}
