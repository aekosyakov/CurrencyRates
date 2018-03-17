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
    func didSelectCurrencyItem(at indexPath: IndexPath)
    func didDeselectCurrencyItem()
    func configureCell(at indexPath: IndexPath) -> UITableViewCell
    func cellHeight(at indexPath:IndexPath) -> CGFloat
}

protocol CurrencyListInteractorPresenter: class {
    
}

typealias CurrencyListPresenterProtocol = CurrencyListViewPresenter & CurrencyListInteractorPresenter

// MARK: - Interactor

protocol CurrencyListInteractorProtocol: class {
    var itemsCount:Int { get }
    func currencyItem(at index:Int, editMode: Bool) -> Currency?
    func editSelectedItemCount(_ count: Float)
    func updateCurrencyItems(_ completion:@escaping ((NSError?)-> ()))
    func addCurrencyItemToTop(from index: Int)
    func stopUpdatingCurrencyItems()
}

// MARK: - View

protocol CurrencyListViewProtocol: class {
    var title: String? { set get }
    var tableView: UITableView! { get}
}

// MARK: - IO

protocol CurrencyListInput: class {
    
}

protocol CurrencyListOutput: class {
    
}

protocol CurrencyListIO: CurrencyListInput {
    weak var output: CurrencyListOutput? { set get }
}

public enum EditingState: Int {
    case shouldBeginEdining, didStartEditing
}

protocol CurrencyCellProtocol {
    var didStartEditing: ((UITextField) -> ())? { set get }
}
