//
//  CurrencyItemTableViewCell.swift
//  CurrencyList
//
//  Created by Alex Kosyakov on 01.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import UIKit

class CurrencyItemTableViewCell: UITableViewCell, CurrencyCellProtocol {
    var didStartEditing: ((UITextField) -> ())?
    let serialQueue: OperationQueue = OperationQueue()
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var rateLabel: UILabel?
    @IBOutlet weak var titleImageView: UIImageView?
    @IBOutlet weak var textField: UITextField?
    private var currencyItem: Currency?
    
    override func awakeFromNib() {
        backgroundColor = .white
        contentView.backgroundColor = .white
        textField?.keyboardType = .numberPad
        textField?.delegate = self
        textField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField?.placeholder = "0"
        serialQueue.maxConcurrentOperationCount = 1
    }
    
    func reload(with item: Currency) {
        currencyItem = item
        updateUI()
    }
    
    func updateUI() {
        serialQueue.cancelAllOperations()
        guard let item = currencyItem else {
            return
        }
        let operation = BlockOperation()
        operation.addExecutionBlock {
            DispatchQueue.main.async {
                if let uid = item.identifier {
                    self.titleLabel?.text = uid
                }
                
                if let count = item.count, item.count != 0 {
                    if item.selected == false || self.textField?.isFirstResponder == false {
                        self.textField?.text =  count.isInt ?  String(format: "%.f", count) :  String(format: "%.2f", count)
                    }
                }
                else {
                    self.textField?.text = nil
                }

                if item.selected == true {
                    self.startEditing()
                } else {
                    self.endEditing()
                }
            }
        }
        serialQueue.addOperation(operation)
    }
    
    public func startEditing() {
        guard textField?.isFirstResponder == false else  {
            return
        }
        textField?.becomeFirstResponder()
    }
    
    public func endEditing() {
        guard textField?.isFirstResponder == true else  {
            return
        }
        textField?.resignFirstResponder()
    }
}

extension CurrencyItemTableViewCell: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let handler = didStartEditing {
            handler(textField)
        }
        return true
    }
    
    @objc func textFieldDidChange(_ textfield:UITextField) {
        if let handler = didStartEditing {
            handler(textfield)
        }
    }
}

extension FloatingPoint {
    var isInt: Bool {
        return floor(self) == self
    }
}
