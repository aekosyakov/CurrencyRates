//
//  NavigationViewController.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 22.02.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import UIKit

final class NavigationViewController: UINavigationController, NavigationViewProtocol {

	var presenter: NavigationViewPresenter!

    
	override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.useCustomStyle()
        presenter.viewLoaded()
    }

}

extension UINavigationBar {
    func useCustomStyle() {
        isOpaque = true
        isTranslucent = false
        tintColor = .white
    }
}
