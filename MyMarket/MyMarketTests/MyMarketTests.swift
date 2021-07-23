//
//  MyMarketTests.swift
//  MyMarketTests
//
//  Created by Jegathas Sivanesan on 18/07/2021.
//

import XCTest
@testable import MyMarket

class MyMarketTests: XCTestCase {

    func testFetchListItems() throws {
        let testExpectation = expectation(description: "should fetch list items ")

        let interator = ListInteractor()
        let presenter = ListPresenterSpy()
        presenter.testExpectation = testExpectation
        interator.presenter = presenter

        let request = List.Request(url: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")
        interator.fetchListItems(request)

        waitForExpectations(timeout: 30) { error in
            if let err = error {
                print(err)
            }
        }
    }

}

class ListPresenterSpy: ListPresentationLogic {
    var testExpectation: XCTestExpectation?

    func presentItems(_ response: List.Response) {
        XCTAssertFalse(response.items.isEmpty)
        XCTAssertFalse(response.categorys.isEmpty)
        testExpectation?.fulfill()
    }

}
