//
//  CurrencyListRouter.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 22.02.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import UIKit

final class CurrencyListRouter: CurrencyListWireframeProtocol {
    enum Error: Swift.Error {
        case submoduleNotFound
    }
    fileprivate weak var view: (UIViewController & CurrencyListViewProtocol)?
    
    var cellSubmodules: [ViperModule <UIView, CurrencyitemIO>] = []
    
    static func createModule(output: CurrencyListOutput? = nil) throws -> ViperModule<UIViewController, CurrencyListIO> {
        let view = CurrencyListViewController(nibName: nil, bundle: nil)
        let interactor = CurrencyListInteractor()
        let router = CurrencyListRouter()
        let presenter = CurrencyListPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        presenter.output = output
        
        return ViperModule(view: view, input: presenter)
    }
    
    
    func createSubmodule(for item: CurrencyItem) throws -> UIView {
        if let module = try? submodule(for: item) {
            return module.view
        }
        
        let module = try CurrencyitemRouter.createModule(output: (self as! CurrencyitemOutput))
        module.input.setItem(item)
        cellSubmodules.append(module)
        return module.view
    }
    
    
    func submodule(for item: CurrencyItem) throws -> ViperModule <UIView, CurrencyitemIO> {
        guard let module = try cellSubmodules.first(where: { try
            $0.input.item().identifier == item.identifier
            
        } ) else {
            throw Error.submoduleNotFound
        }
        return module
    }
}
