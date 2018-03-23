//
//  CurrencyListProtocols.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 22.02.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import Foundation
import UIKit.UITableView

// MARK: - Wireframe

protocol CurrencyListWireframeProtocol: class {

}

// MARK: - Presenter

protocol CurrencyListViewPresenter: class {
    func viewLoaded()
    func numberOfItems() -> Int
    func selectItem(at indexPath: IndexPath)
    func deselectItem(at indexPath: IndexPath)
    func item(at indexPath:IndexPath) -> Currency?
    func cellTextFieldDidStartEditing(_ textField: UITextField)
}

protocol CurrencyListInteractorPresenter: class {
    func show(error: CurrencyError)
    func hideError()
    func hideLoader()
}

typealias CurrencyListPresenterProtocol = CurrencyListViewPresenter & CurrencyListInteractorPresenter

// MARK: - Interactor

protocol CurrencyListInteractorProtocol: class {
    var itemsFabric:CurrencyItemsFabric { get }

    func updateCurrencyItems(_ completion:@escaping ((CurrencyError?)-> ()))
    func stopUpdatingCurrencyItems()
    
}

// MARK: - View

protocol CurrencyListViewProtocol: class {
    var title: String? { set get }
    func moveRowToTop(from indexPath:IndexPath)
    func reloadVisibleRows()
    func insertNewRows()
}

// MARK: - IO

protocol CurrencyListInput: class {
    
}

protocol CurrencyListOutput: class {
    func showLoaderPlaceholder(input: CurrencyListInput)
    func showErrorPlaceholder(error:CurrencyError, input: CurrencyListInput)
    func hideErrorPlaceholder(input: CurrencyListInput)
    func hideLoaderPlaceholder(input: CurrencyListInput)
}

protocol CurrencyListIO: CurrencyListInput {
    weak var output: CurrencyListOutput? { set get }
}

public enum EditingState: Int {
    case shouldBeginEdining, didStartEditing
}

enum PlaceholderType {
    case error(CurrencyError), loader
}

typealias PlaceholderData = (text: String, icon: String?)

protocol CurrencyCellProtocol: class {
    func reload(with itemViewModel:CurrencyItemViewModel)
}
