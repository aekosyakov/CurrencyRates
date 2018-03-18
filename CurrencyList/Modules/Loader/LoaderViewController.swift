//
//  LoaderViewController.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 17.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import UIKit

final class LoaderViewController: UIViewController, LoaderViewProtocol {

	var presenter: LoaderViewPresenter!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
        view.layoutIfNeeded()
        self.title = self.presentingViewController?.title ?? ""
    }
}
