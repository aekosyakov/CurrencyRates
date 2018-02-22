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

	var presenter: CurrencyListViewPresenter!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
    }

}
