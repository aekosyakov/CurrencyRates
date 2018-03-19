//
//  CurrencyListViewController.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 22.02.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import UIKit
import Repeat

final class CurrencyListViewController: UIViewController, CurrencyListViewProtocol {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var networkActivityView:UIView?
    
	var presenter: CurrencyListViewPresenter!
    
    fileprivate enum CellConsts {
        static let CurrencyCellID = "CurrencyItemTableViewCell"
        static let CellHeight:CGFloat = 100
    }


	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
        
        setupView()
    }
    
    func setupView() {
        view.layoutIfNeeded()
        tableView.delegate = self
        //tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib.init(nibName: CellConsts.CurrencyCellID, bundle: nil), forCellReuseIdentifier: CellConsts.CurrencyCellID)
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
    }
    
    func setNetworkActivityViewColor(_ color: UIColor) {
        networkActivityView?.backgroundColor = color
    }
    
    
}

// MARK: - UITableViewDataSource
extension CurrencyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellConsts.CurrencyCellID, for: indexPath) as! CurrencyItemTableViewCell
        cell.didStartEditing = presenter.cellTextFieldDidStartEditing
        if let item = presenter.item(at: indexPath) {
            let viewModel = CurrencyItemViewModel(item: item)
            cell.reload(with: viewModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CellConsts.CellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
        cell.backgroundColor = .white
    }
}


// MARK: - UIScrollViewDelegate
extension CurrencyListViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        deselectVisibleRows()
        tableView?.endEditing(true)
    }
}


// MARK: - UITableViewDelegate
extension CurrencyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectItem(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        presenter.deselectItem(at: indexPath)
    }
    
}

// MARK: - Rows Handling & Updating
extension CurrencyListViewController {
    func deselectVisibleRows() {
        tableView.indexPathsForVisibleRows?.forEach {
            self.tableView.deselectRow(at: $0, animated: true)
            self.tableView(self.tableView, didDeselectRowAt: $0)
        }
    }
    
    func reloadVisibleRows() {
        let rowsExist = tableView.numberOfRows(inSection: 0) > 0
        
        if  rowsExist == false  {
            DispatchQueue.main.async {
                self.insertNewRows()
            }

        }
        
        tableView.visibleCells.forEach {
            if let indexPath = self.tableView.indexPath(for: $0), let item = presenter.item(at: indexPath) {
                let viewModel = CurrencyItemViewModel(item: item)
                ($0 as? CurrencyItemTableViewCell)!.reload(with: viewModel)
            }
        }
    }
    
    func moveRowToTop(from indexPath:IndexPath) {
        tableView.moveRowToTop(from: indexPath)
    }
    
    
    func insertNewRows() {
        var indexPathsToInsert:[IndexPath] = []
        let numberOfItems = presenter.numberOfItems()
        if numberOfItems == 0 {
            tableView.reloadData()
            return
        }
        let countToInsert = numberOfItems - 1
        for i in  0...countToInsert {
            indexPathsToInsert.append(IndexPath(row:i, section:0))
        }
        tableView?.insertRows(at: indexPathsToInsert)
        
    }
}

