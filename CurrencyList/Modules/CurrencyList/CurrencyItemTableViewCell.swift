//
//  CurrencyItemTableViewCell.swift
//  CurrencyList
//
//  Created by Alex Kosyakov on 01.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import UIKit

class CurrencyItemTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var rateLabel: UILabel?
    @IBOutlet weak var textField: UITextField?
    @IBOutlet weak var countSeparatorView: UIView?
    var didStartEditing: ((UITextField) -> ())?
    
    private let serialQueue: OperationQueue = OperationQueue()
    private var itemViewModel: CurrencyItemViewModel?
    
    override func awakeFromNib() {
        textField?.keyboardType = .numberPad
        textField?.delegate = self
        textField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField?.placeholder = "0"
        textField?.tintColor = .black
        serialQueue.maxConcurrentOperationCount = 1
    }
    
    func updateUI() {
        serialQueue.cancelAllOperations()
        guard let viewModel = itemViewModel else {
            return
        }
        let operation = BlockOperation()
        operation.addExecutionBlock {
            DispatchQueue.main.async {
                let isEditing = self.textField?.isFirstResponder ?? false
                self.titleLabel?.text = viewModel.itemIDText() ?? nil
                let existedText = self.textField?.text ?? nil

                self.textField?.text = viewModel.itemCountText(isEditing: isEditing) ??  (isEditing ? existedText : nil)
                self.textField?.textColor = viewModel.countColor(isEditing:isEditing, oldText:existedText)
                self.countSeparatorView?.backgroundColor = viewModel.separatorColor()
                self.showKeyboard(viewModel.shouldOpenKeyboard())
            }
        }
        serialQueue.addOperation(operation)
        
    }
    
   
}

extension CurrencyItemTableViewCell: CurrencyCellProtocol {
    func reload(with itemViewModel:CurrencyItemViewModel) {
        self.itemViewModel = itemViewModel
        updateUI()
    }
}

extension CurrencyItemTableViewCell {
    func showKeyboard(_ show:Bool) {
        show ? startEditing() : endEditing()
    }
    
    private func startEditing() {
        guard let textField = textField, textField.isFirstResponder == false else {
            return
        }
        DispatchQueue.main.async {
            textField.becomeFirstResponder()
        }
    }
    
    private func endEditing() {
        guard let textField = textField, textField.isFirstResponder == false else {
            return
        }
        DispatchQueue.main.async {
            textField.resignFirstResponder()
        }
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
        serialQueue.cancelAllOperations()
        if let handler = didStartEditing {
            handler(textfield)
        }
    }
}
