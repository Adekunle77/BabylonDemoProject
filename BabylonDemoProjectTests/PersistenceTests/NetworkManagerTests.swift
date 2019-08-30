//
//  SavaDataTests.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 13/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import XCTest
@testable import BabylonDemoProject

class NetworkManagerTests: XCTestCase {
    class CoreDataLoadManagerDelegateSpy: CoreDataLoadManagerDelegate {
        var spyModelDidUpdateData = false
        var spyModelDidUpdateDataWithError: [Error]?
        func didLoadCoreData() {
            spyModelDidUpdateData = true
        }
        func didLoadCoreDataError(error: [Error]) {
            spyModelDidUpdateDataWithError = error
        }
    }

    func testSaveDataFetchDataReturnsError() {
        let mockAPI = MockAPI(isReturningError: true)
        let spy = CoreDataLoadManagerDelegateSpy()
        let saveData = NetworkManager(dataSource: mockAPI)
        let path = URLEndpoint.comments
        saveData.fetchAPIData(with: path, completion: { result in
            switch result {
            case .failure(let error):
                var errorArray = [Error]()
                errorArray.append(error)
                spy.didLoadCoreDataError(error: errorArray)
            case .success:
                spy.didLoadCoreData()
            }
        })
        XCTAssertFalse(spy.spyModelDidUpdateData)
        XCTAssertNotNil(spy.spyModelDidUpdateDataWithError)
    }

    func testSaveDataFetchAuthorDataReturnsSuccess() {
        let mockAPI = MockAPI(isReturningError: false)
        let spy = CoreDataLoadManagerDelegateSpy()
        let saveData = NetworkManager(dataSource: mockAPI)
        let path = URLEndpoint.users
        saveData.fetchAPIData(with: path, completion: { result in
            switch result {
            case .failure(let error):
                var errorArray = [Error]()
                errorArray.append(error)
                spy.didLoadCoreDataError(error: errorArray)
            case .success:
                spy.didLoadCoreData()
            }
        })
        XCTAssertTrue(spy.spyModelDidUpdateData)
        XCTAssertNil(spy.spyModelDidUpdateDataWithError)
    }

    func testSaveDataFetchCommentsDataReturnsSuccess() {
        let mockAPI = MockAPI(isReturningError: false)
        let spy = CoreDataLoadManagerDelegateSpy()
        let saveData = NetworkManager(dataSource: mockAPI)
        let path = URLEndpoint.comments
        saveData.fetchAPIData(with: path, completion: { result in
            switch result {
            case .failure(let error):
                var errorArray = [Error]()
                errorArray.append(error)
                spy.didLoadCoreDataError(error: errorArray)
            case .success:
                spy.didLoadCoreData()
            }
        })
        XCTAssertTrue(spy.spyModelDidUpdateData)
        XCTAssertNil(spy.spyModelDidUpdateDataWithError)
    }

    func testSaveDataFetchTitleDataReturnsSuccess() {
        let mockAPI = MockAPI(isReturningError: false)
        let spy = CoreDataLoadManagerDelegateSpy()
        let saveData = NetworkManager(dataSource: mockAPI)
        let path = URLEndpoint.posts
        saveData.fetchAPIData(with: path, completion: { result in
            switch result {
            case .failure(let error):
                var errorArray = [Error]()
                errorArray.append(error)
                spy.didLoadCoreDataError(error: errorArray)
            case .success:
                spy.didLoadCoreData()
            }
        })
        XCTAssertTrue(spy.spyModelDidUpdateData)
        XCTAssertNil(spy.spyModelDidUpdateDataWithError)
    }
}
