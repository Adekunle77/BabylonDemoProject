//
//  ContentStateViewModelTests.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 17/07/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import XCTest
@testable import BabylonDemoProject

class ContentStateViewModelTests: XCTestCase {
    var storageManager: StorageManager!
    let mockPersistentContainer = MockPersistentContainer()
    let contentStateViewModel = ContentStateViewModel()
    let properties = TestProperties()
    var convertedString = String()
    class MockContentStateDelegate: ContentFetchingStateDelegate {
        var timesDidLoadDataCalled = 0
        var timesErrorCalled = 0
        var timesDataIsLoadingCalled = 0

        func dataIsLoading() {
            timesDataIsLoadingCalled += 1
        }

        func didUpdateWithData() {
            timesDidLoadDataCalled += 1
        }

        func didUpdateWithError(error: [Error]) {
            timesErrorCalled += 1
        }
    }

    override func setUp() {
        super.setUp()
        storageManager = StorageManager(persistentContainer: mockPersistentContainer.mockPersistentContainer)
    }

    func testLoadData() {
        let mockAPI = MockAPI(isReturningError: true)
        let mockNetworkManager = MockNetworkManager(networkManager: mockAPI)
        let loadManager = AllContentProvider(networkManager: mockNetworkManager)
        let mockDelegate = MockContentStateDelegate()
        contentStateViewModel.delegate = mockDelegate

        loadManager.fetchAllContent()
        contentStateViewModel.loadData()

        XCTAssertEqual(mockDelegate.timesDataIsLoadingCalled, 1)
    }
}
