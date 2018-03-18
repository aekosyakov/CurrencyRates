//
//  ErrorPlaceholderViewController.swift
//  CurrencyList
//
//  Created Alex Kosyakov on 18.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//
//

import UIKit

final class ErrorPlaceholderViewController: UIViewController, ErrorPlaceholderViewProtocol {
    @IBOutlet weak var errorLabel:UILabel?
    @IBOutlet weak var imageView:UIImageView?
    
	var presenter: ErrorPlaceholderViewPresenter!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
        
    }
    
    
    func setErrorText(_ text:String) {
        errorLabel?.text = text
    }
    
    func setIcon(_ image: UIImage) {
        imageView?.image = image
    }

}
