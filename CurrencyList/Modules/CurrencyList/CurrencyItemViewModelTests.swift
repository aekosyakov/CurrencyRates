//
//  CurrencyItemViewModelTests.swift
//  CurrencyListTests
//
//  Created by Alex Kosyakov on 18.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import XCTest

class CurrencyItemViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testShouldReturnNilValueForEmptyItem() {
        let item = CurrencyItem()
        let model = CurrencyItemViewModel(item: item)
        let expectation = XCTestExpectation(description: "\(#function)")
        XCTAssertTrue(model.itemIDText() == nil)
        XCTAssertTrue(model.itemCountText(isEditing: true) == nil)
        XCTAssertTrue(model.countColor(isEditing: true, oldText: nil) == .black)
        XCTAssertTrue(model.shouldOpenKeyboard() == false)
        expectation.fulfill()
        wait(for: [expectation], timeout: 1)
    }
    
}
