//
//  LoaderRouter.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 17.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import UIKit

final class LoaderRouter: LoaderWireframeProtocol {
    
    fileprivate weak var view: (UIViewController & LoaderViewProtocol)?
    
    static func createModule(output: LoaderOutput? = nil) throws -> ViperModule<UIViewController, LoaderIO> {
        let view = LoaderViewController(nibName: nil, bundle: nil)
        let interactor = LoaderInteractor()
        let router = LoaderRouter()
        let presenter = LoaderPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        presenter.output = output
        
        return ViperModule(view: view, input: presenter)
    }
}
