//
//  CurrencyListInteractorTests.swift
//  CurrencyListTests
//
//  Created by Alex Kosyakov on 18.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import XCTest

class CurrencyListInteractorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShouldReturnFirstBaseCurrencyInArrayByDefault() {
        let expectation = XCTestExpectation(description: "\(#function)")
        
        let updateService = CurrencyItemsUpdateService(fetchService: CurrencyItemsFetchService())
        let interactor = CurrencyListInteractor(updateService:updateService)
        interactor.updateCurrencyItems { (error) in
            if let error = error {
                XCTFail("error \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let item = interactor.currencyItem(at: 0, editMode: false), let itemID = item.identifier else {
                XCTFail("item not created")
                expectation.fulfill()
                return
            }
            XCTAssertTrue(itemID == updateService.currentBaseID())
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
    

    
}
