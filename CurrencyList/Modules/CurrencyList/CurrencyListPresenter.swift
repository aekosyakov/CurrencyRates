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
    
    init(view: CurrencyListViewProtocol, interactor: CurrencyListInteractorProtocol, router: CurrencyListWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension CurrencyListPresenter: CurrencyListViewPresenter {
    
    
    func viewLoaded() {
        view?.title = "Currency List"
        NotificationCenter.default.addObserver(forName: .UIApplicationDidBecomeActive, object: nil, queue: OperationQueue.main) { _ in
            self.startUpdates()
        }
        
        NotificationCenter.default.addObserver(forName: .UIApplicationDidEnterBackground, object: nil, queue: OperationQueue.main) { _ in
            self.stopUpdates()
        }
        startUpdates()
    }
    
    
    //MARK: - Public API
    func item(at indexPath:IndexPath) -> Currency? {
        return interactor.currencyItem(at: indexPath.row, editMode: editMode)
    }
    
    func selectItem(at indexPath: IndexPath) {
        let index = indexPath.row
    
        editMode = true
        
        guard index != 0 else {
            reloadRows()
            return
        }
        
        interactor.addCurrencyItemToTop(from: index)
        
        DispatchQueue.main.async {
            self.view.moveRowToTop(from: indexPath)
            self.view.reloadVisibleRows()
            
        }
    }
    
    func deselectItem(at indexPath: IndexPath) {
        deselectItems()
    }
    
    func numberOfItems() -> Int {
        return interactor.itemsCount
    }
    
    func cellTextFieldDidStartEditing(_ textField: UITextField) {
        if let text = textField.text {
            interactor.editSelectedItemCount(Float(text) ?? 0)
            reloadRows()
        }
    }
    
    
    //MARK: - Private API
    private func startUpdates() {
        if self.interactor.itemsCount == 0 {
            self.showLoader()
        }
        interactor.updateCurrencyItems { error in
            self.hideLoader()
            
            if let error = error {
                self.show(error: error)
                return
            }
            
            self.hideError()
            self.reloadRows()
        }
    }

    
    private func stopUpdates() {
        interactor.stopUpdatingCurrencyItems()
    }
    
    
    private func deselectItems() {
        editMode = false
        reloadRows()
    }
    
    private func reloadRows() {
        DispatchQueue.main.async {
            self.view.reloadVisibleRows()
        }
    }
}

extension CurrencyListPresenter: CurrencyListInteractorPresenter {
    
    func show(error: CurrencyError) {        
        output?.showErrorPlaceholder(error: error, input: self)
    }
    
    func hideError() {
        output?.hideErrorPlaceholder(input: self)
    }
    
    func showLoader() {
        output?.showLoaderPlaceholder(input: self)
    }
    
    func hideLoader() {
        output?.hideLoaderPlaceholder(input: self)
    }
}

extension CurrencyListPresenter: CurrencyListIO {
    
}

