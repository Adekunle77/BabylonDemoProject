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
    var coreDataManager: StorageManager!
    let mockPersistantContainer = MockPersistantContainer()
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
    
    override func setUp() {
        super.setUp()
        coreDataManager = StorageManager(persistentContainer: mockPersistantContainer.mockPersistantContainer)
    }
    
    func testFetchDataReturnsData() {
        let dataSource = MockNetworkManager()
        let loadManager = LoadManager(networkManager: dataSource)
        let spy = MockDelegate()
        loadManager.delegate = spy
        let mockAPI = MockAPI()
        mockAPI.isReturningError = true 
        loadManager.fetchData()
 
       XCTAssertEqual(spy.timesDidLoadDataCalled, 1)
       XCTAssertEqual(spy.timesDidLoadDataCalled, 1)
    }
    

}
