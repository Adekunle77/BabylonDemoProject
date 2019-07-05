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
    class CoreDataLoadManagerDelegateSpy: CoreDataLoadManagerDelegate {
        var spyModelDidUpdateData = false
        var timesErrorCalled = 0
        var timesModelDidUpdateCalled = 0
        var spyModelDidUpdateDataWithError: [Error]?
        
        func didLoadCoreData() {
            timesModelDidUpdateCalled += 1
            spyModelDidUpdateData = true
        }
        func didLoadCoreDataError(error: [Error]) {
             timesErrorCalled += 1
            spyModelDidUpdateDataWithError = error
        }
    }
    
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
    
    func testFetchDataReturnsError() {
        let spy = MockDelegate()
        let mockAPI = MockAPI()
        mockAPI.isReturningError = true
        let dataSource = MockNetwork(api: mockAPI)
        let loadManager = LoadManager(networkManager: dataSource)
        loadManager.delegate = spy
        loadManager.fetchData()

    
        XCTAssertEqual(spy.timesErrorCalled, 1)
         XCTAssertEqual(spy.timesDidLoadDataCalled, 1)
    }
}
