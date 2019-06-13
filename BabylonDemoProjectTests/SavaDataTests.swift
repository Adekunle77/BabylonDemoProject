//
//  SavaDataTests.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 13/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

@testable import BabylonDemoProject
import XCTest

class SavaDataTests: XCTestCase {
    class SaveDataDelegateSpy: SaveDataDelegate {
        var spyModelDidUpdateData = false
        var spyModelDidUpdateDataWithError: Error?

        func dataDidSaveAuthor() {
            spyModelDidUpdateData = true
        }

        func dataDidSaveTitle() {
            spyModelDidUpdateData = true
        }

        func dataDidSaveComment() {
            spyModelDidUpdateData = true
        }

        func dataSavingError(error: Error) {
            spyModelDidUpdateDataWithError = error
        }
    }

    var mockAPI = MockAPI()

    func testSaveDataFetchDataReturnsError() {
        mockAPI.isReturningError = true
        let spy = SaveDataDelegateSpy()
        let saveData = CoreDataSaveManager(dataSource: mockAPI)
        saveData.delegate = spy
        let path = URLEndpoint(path: Paths.commentsUrlPath)

        saveData.fetchAPIData(with: path)

        XCTAssertFalse(spy.spyModelDidUpdateData)
        XCTAssertNotNil(spy.spyModelDidUpdateDataWithError)
    }

    func testSaveDataFetchAuthorDataReturnsSuccess() {
        mockAPI.isReturningError = false
        let spy = SaveDataDelegateSpy()
        let saveData = CoreDataSaveManager(dataSource: mockAPI)
        saveData.delegate = spy
        let path = URLEndpoint(path: Paths.authorUrlPath)

        saveData.fetchAPIData(with: path)

        XCTAssertTrue(spy.spyModelDidUpdateData)
        XCTAssertNil(spy.spyModelDidUpdateDataWithError)
    }

    func testSaveDataFetchCommentsDataReturnsSuccess() {
        mockAPI.isReturningError = false
        let spy = SaveDataDelegateSpy()
        let saveData = CoreDataSaveManager(dataSource: mockAPI)
        saveData.delegate = spy
        let path = URLEndpoint(path: Paths.commentsUrlPath)

        saveData.fetchAPIData(with: path)

        XCTAssertTrue(spy.spyModelDidUpdateData)
        XCTAssertNil(spy.spyModelDidUpdateDataWithError)
    }

    func testSaveDataFetchTitleDataReturnsSuccess() {
        mockAPI.isReturningError = false
        let spy = SaveDataDelegateSpy()
        let saveData = CoreDataSaveManager(dataSource: mockAPI)
        saveData.delegate = spy
        let path = URLEndpoint(path: Paths.postsUrlPath)

        saveData.fetchAPIData(with: path)

        XCTAssertTrue(spy.spyModelDidUpdateData)
        XCTAssertNil(spy.spyModelDidUpdateDataWithError)
    }
}
