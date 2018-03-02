//
//  CurrencyListViewController.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 22.02.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import UIKit

final class CurrencyListViewController: UIViewController, CurrencyListViewProtocol {
    @IBOutlet weak var tableView: UITableView!
    
	var presenter: CurrencyListViewPresenter!
    
    fileprivate enum CellConsts {
        static let CurrencyCellID = "CurrencyItemTableViewCell"
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
        tableView.register(CurrencyItemTableViewCell.self, forCellReuseIdentifier: CellConsts.CurrencyCellID)
    }

}

// MARK: - UITableView


extension CurrencyListViewController: UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: CellConsts.CurrencyCellID, for: indexPath) as! CurrencyItemTableViewCell
        let item = presenter.currencyItem(at: indexPath.row)
        
       // cell.setupCustomContent
        
      //  let track = currencies[indexPath.row]
      //  cell.configure(track: track, downloaded: track.downloaded)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
}

extension CurrencyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let currency = presenter.currencyItem(at: indexPath.row)
        presenter.didSelectCurrencyItem(at: indexPath.row)
    }
}
