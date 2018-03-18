//
//  CurrencyListUtils.swift
//  CurrencyList
//
//  Created by Alex Kosyakov on 17.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import UIKit

public extension FloatingPoint {
    var isInt: Bool {
        return floor(self) == self
    }
}



public extension String {
    public func toFloat() -> Float? {
        return Float.init(self)
    }
    
    public func toDouble() -> Double? {
        return Double.init(self)
    }
    
    public func toInt() -> Int? {
        return Int.init(self)
    }
}

public extension UITableView {
    func moveRowToTop(from indexPath:IndexPath) {
        beginUpdates()
        moveRow(at: indexPath, to: IndexPath(row:0, section:0))
        endUpdates()
        scrollToRow(at: IndexPath(row:0, section:0), at: .top, animated: false)
    }
    
    func insertRows(at indexPaths:[IndexPath]) {
        self.beginUpdates()
        self.insertRows(at: indexPaths, with: .automatic)
        self.endUpdates()
    }
}

public extension IndexPath {
    static func first() -> IndexPath {
        return IndexPath(row:0, section:0)
    }
}
