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
    var mockAPI = MockAPI()

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
        mockAPI.isReturningError = true
        let spy = CoreDataLoadManagerDelegateSpy()
        let saveData = CoreDataSaveManager(dataSource: mockAPI)
        let path = URLEndpoint(path: Paths.commentsUrlPath)

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
        mockAPI.isReturningError = false
        let spy = CoreDataLoadManagerDelegateSpy()
        let saveData = CoreDataSaveManager(dataSource: mockAPI)
        let path = URLEndpoint(path: Paths.authorUrlPath)

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
        mockAPI.isReturningError = false
        let spy = CoreDataLoadManagerDelegateSpy()
        let saveData = CoreDataSaveManager(dataSource: mockAPI)
        let path = URLEndpoint(path: Paths.commentsUrlPath)

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
        mockAPI.isReturningError = false
        let spy = CoreDataLoadManagerDelegateSpy()
        let saveData = CoreDataSaveManager(dataSource: mockAPI)
        let path = URLEndpoint(path: Paths.postsUrlPath)

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
