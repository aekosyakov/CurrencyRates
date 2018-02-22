//
//  NavigationViewController.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 22.02.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import UIKit

final class NavigationViewController: UIViewController, NavigationViewProtocol {

	var presenter: NavigationViewPresenter!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
    }

}
