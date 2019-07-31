//
//  LoadManagerTests.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 03/07/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import CoreData
import XCTest
@testable import BabylonDemoProject

class LoadManagerTests: XCTestCase {

    final class MockDelegate: CoreDataLoadManagerDelegate {
        var timesDidLoadDataCalled = 0
        var timesErrorCalled = 0
        
        func didLoadCoreData() {
            timesDidLoadDataCalled += 1
        }

        func didLoadCoreDataError(error: [Error]) {
            timesErrorCalled += 1
        }
    }

    func testFetchDataReturnsData() {
        let mockAPI = MockAPI(isReturningError: false)
        let spy = MockDelegate()
        let dataSource = MockNetworkManager(networkManager: mockAPI)
        let loadManager = LoadManager(networkManager: dataSource)
        let postsPath = URLEndpoint(path: Paths.postsUrlPath)
        loadManager.networkManager.fetchAPIData(with: postsPath, completion: { result in
            switch result {
            case let .failure(error):
                var errorsArray = [Error]()
                errorsArray.append(error)
                spy.didLoadCoreDataError(error: errorsArray)
            case .success:
                spy.didLoadCoreData()
            }
        })
        loadManager.fetchData()
        XCTAssertEqual(spy.timesErrorCalled, 0)
        XCTAssertEqual(spy.timesDidLoadDataCalled, 1)
    }
    
    func testFetchDataReturnsError() {
        let mockAPI = MockAPI(isReturningError: true)
        let spy = MockDelegate()
        let dataSource = MockNetworkManager(networkManager: mockAPI)
        let loadManager = LoadManager(networkManager: dataSource)
        let postsPath = URLEndpoint(path: Paths.postsUrlPath)
        loadManager.networkManager.fetchAPIData(with: postsPath, completion: { result in
            switch result {
            case let .failure(error):
                var errorsArray = [Error]()
                errorsArray.append(error)
                spy.didLoadCoreDataError(error: errorsArray)
            case .success:
                spy.didLoadCoreData()
            }
        })
        loadManager.fetchData()
        XCTAssertEqual(spy.timesErrorCalled, 1)
        XCTAssertEqual(spy.timesDidLoadDataCalled, 0)
    }
}
