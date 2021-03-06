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
 
    fileprivate weak var view: (UIViewController & CurrencyListViewProtocol)?
    
    static func createModule(output: CurrencyListOutput? = nil) throws -> ViperModule<UIViewController, CurrencyListIO> {
        let view = CurrencyListViewController(nibName: nil, bundle: nil)
        let fetchService = CurrencyItemsFetchService()
        let updateService = CurrencyItemsUpdateService(fetchService: fetchService)
        
        let storage = CurrencyStorage()
        let itemsFabric = CurrencyItemsFabric(storage: storage)
        let interactor = CurrencyListInteractor(updateService: updateService, itemsFabric: itemsFabric)
        let router = CurrencyListRouter()
        let presenter = CurrencyListPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        presenter.output = output
        
        return ViperModule(view: view, input: presenter)
    }
}
