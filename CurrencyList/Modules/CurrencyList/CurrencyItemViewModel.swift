//
//  CurrencyItemViewModel.swift
//  CurrencyList
//
//  Created by Alex Kosyakov on 17.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import UIKit

class CurrencyItemViewModel: NSObject {
    let item: Currency
    init(item:Currency) {
        self.item = item
    }
    
    
    func itemIDText() -> String? {
        if let uid = item.identifier {
            return uid
        }
        return nil
    }
    
    
    func itemCountText(isEditing:Bool) -> String? {
        if let count = item.count, count != 0 {
            if item.selected == false || isEditing == false {
                return  count.isInt ?  String(format: "%.f", count) : String(format: "%.2f", count)
            }
        }
         return nil
    }
    
    func countColor(isEditing:Bool, oldText:String?) -> UIColor {
        guard let positiveItemCount = itemCountText(isEditing: isEditing), let existedText = oldText, let oldFloatValue = Float(existedText), let newFloatValue = Float(positiveItemCount), newFloatValue != 0 else {
            return .black

        }
        let gotLess = newFloatValue < oldFloatValue
        
        if gotLess {
            return .red
        }
        
        return .green
    }
    
    func shouldOpenKeyboard() -> Bool {
        return item.selected
    }
}
