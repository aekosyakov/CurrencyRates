//
//  CurrencyItemsFetchServiceTest.swift
//  CurrencyListTests
//
//  Created by Alex Kosyakov on 18.03.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

import XCTest
import Reachability


class CurrencyItemsFetchServiceTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    
    func testShouldFailWithoutConnection() {
        let rechability = Reachability()
        let fetchService = CurrencyItemsFetchService()
        let baseID = CurrencyIDs.usd
        let expectation = XCTestExpectation(description: "\(#function)")
        
        fetchService.loadRates(base: baseID) {
            print($0)
            switch $0 {
            case .failure(let error):
                switch error {
                case .connectionLost:
                    XCTAssertTrue(rechability?.connection == .none)
                default:
                    XCTFail("\(error)")
                }
                print("error \(error.localizedDescription)")
            case .success:
                XCTAssertTrue(rechability?.connection != .none)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func textShouldWorkWithUSDCurrency() {
        let fetchService = CurrencyItemsFetchService()
        let baseID = CurrencyIDs.usd
        let expectation = XCTestExpectation(description: "\(#function)")
        fetchService.loadRates(base: baseID) {
            print($0)
            switch $0 {
            case .failure(let error):
                XCTFail("\(error)")
                print("error \(error.localizedDescription)")
            case .success(let data):
                 XCTAssertEqual(data.baseID, baseID)
                print("\(data.rates)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
}
