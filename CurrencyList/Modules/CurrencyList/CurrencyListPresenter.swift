//
//  CurrencyListPresenter.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 22.02.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import UIKit

final class CurrencyListPresenter {

    fileprivate weak var view: CurrencyListViewProtocol!
    fileprivate let interactor: CurrencyListInteractorProtocol
    fileprivate let router: CurrencyListWireframeProtocol
    
    weak var output: CurrencyListOutput?
    private var editMode:Bool = false
    
    fileprivate enum CellConsts {
        static let CurrencyCellID = "CurrencyItemTableViewCell"
    }
    
    init(view: CurrencyListViewProtocol, interactor: CurrencyListInteractorProtocol, router: CurrencyListWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension CurrencyListPresenter: CurrencyListViewPresenter {
    
    func viewLoaded() {
        view?.title = "CurrencyList"
        view?.tableView.register(UINib.init(nibName: CellConsts.CurrencyCellID, bundle: nil), forCellReuseIdentifier: CellConsts.CurrencyCellID)
        
        NotificationCenter.default.addObserver(forName: .UIApplicationDidBecomeActive, object: nil, queue: OperationQueue.main) { _ in
            self.startUpdates()
        }
        
        NotificationCenter.default.addObserver(forName: .UIApplicationDidEnterBackground, object: nil, queue: OperationQueue.main) { _ in
            self.stopUpdates()
        }
    }
    
    //MARK: - Public API
    func currencyCell(at indexPath: IndexPath) -> CurrencyItemTableViewCell {
        return view.tableView.dequeueReusableCell(withIdentifier: CellConsts.CurrencyCellID, for: indexPath) as! CurrencyItemTableViewCell
    }
    
    func configureCell(at indexPath: IndexPath) -> UITableViewCell {
        
        let cell = currencyCell(at: indexPath)
        cell.didStartEditing = cellTextFieldDidStartEditing
        
        if let item = interactor.currencyItem(at: indexPath.row, editMode: editMode) {
            cell.reload(with:item)
        }
        return cell
    }
    
    func didSelectCurrencyItem(at indexPath: IndexPath) {
        let index = indexPath.row
        
        editMode = true
        
        print(index)
        guard index != 0 else {
            reloadCells()
            return
        }
        
        interactor.addCurrencyItemToTop(from: index)
        
        DispatchQueue.main.async {
//            if let cell = self.view.tableView.cellForRow(at: indexPath) as? CurrencyItemTableViewCell, let item = self.interactor.currencyItem(at: indexPath.row, editMode: self.editMode) {
//                cell.reload(with:item)
//            }
            self.view.tableView.moveRowToTop(from: indexPath)
            self.reloadCells()
        }
    }
    
    func didDeselectCurrencyItem() {
        editMode = false
        DispatchQueue.main.async {
            self.reloadCells()
        }
    }
    
    func numberOfItems() -> Int {
        return interactor.itemsCount
    }
    
    func cellHeight(at indexPath:IndexPath) -> CGFloat {
        return 100
    }
    
    //MARK: - Private API
    private func startUpdates() {
        print("start updates")
        interactor.updateCurrencyItems { error in
            if let error = error {
                self.handle(error: error)
            } else {
                DispatchQueue.main.async {
                    let numberOfItems = self.view.tableView.numberOfRows(inSection: 0)
                    if numberOfItems == 0 {
                        self.view.tableView.reloadData()
                    }
                    self.reloadCells()
                }
            }
        }
    }
    
    private func stopUpdates() {
        self.interactor.stopUpdatingCurrencyItems()
    }
    
    private func handle(error: NSError) {
        print("error\(error.localizedDescription)")
    }
    
    
    private func cellTextFieldDidStartEditing(_ textField: UITextField) {
        if let text = textField.text, let floatValue = Float(text) {
            interactor.editSelectedItemCount(floatValue)
            DispatchQueue.main.async {
                self.reloadCells()
            }
        }
    }
    
    private func reloadCells() {
        self.view.tableView.visibleCells.forEach { (cell) in
            let visibleIndexPath = self.view.tableView.indexPath(for: cell)
            if let item = interactor.currencyItem(at: (visibleIndexPath?.row)!, editMode: editMode){
                (cell as? CurrencyItemTableViewCell)!.reload(with: item)
            }
        }
    }
}

extension CurrencyListPresenter: CurrencyListInteractorPresenter {
    
}

extension CurrencyListPresenter: CurrencyListIO {
    
}

public extension String {
    public func toFloat() -> Float? {
        return Float.init(self)
    }
    
    public func toDouble() -> Double? {
        return Double.init(self)
    }
    
    public func toInt() -> Int? {
        return Int.init(self)
    }
}

public extension UITableView {
    func moveRowToTop(from indexPath:IndexPath) {
        beginUpdates()
        moveRow(at: indexPath, to: IndexPath(row:0, section:0))
        endUpdates()
        scrollToRow(at: IndexPath(row:0, section:0), at: .top, animated: false)
    }
}

public extension IndexPath {
    static func first() -> IndexPath {
        return IndexPath(row:0, section:0)
    }
}
