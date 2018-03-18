//
//  CurrencyItemsUpdateServiceTests.swift
//  CurrencyListTests
//
//  Created by Alex Kosyakov on 18.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import XCTest

class CurrencyItemsUpdateServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func textShouldReturnResponseEverySec() {
        let fetchService = CurrencyItemsFetchService()
        let updateService = CurrencyItemsUpdateService(fetchService: fetchService)
        let expectation = XCTestExpectation(description: "\(#function)")
        updateService.startUpdateRates(every: 1) {
            switch $0 {
            case .failure(let error):
                XCTFail("\(error)")
                print("error \(error.localizedDescription)")
            case .success:
                XCTAssertTrue(true)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
}
