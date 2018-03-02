//
//  CurrencyItemTableViewCell.swift
//  CurrencyList
//
//  Created by Alex Kosyakov on 01.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import UIKit

class CurrencyItemTableViewCell: UITableViewCell {
    var customContentView: UIView?
    
    func setupCustomContentView(_ view: UIView?, animated: Bool = false) {
        customContentView?.removeFromSuperview()
        customContentView = nil
        
        if let view = view {
            contentView.addSubview(view)
            view.addConstraintsToSuperviewBounds()
            customContentView = view
        }
        
    }
}
