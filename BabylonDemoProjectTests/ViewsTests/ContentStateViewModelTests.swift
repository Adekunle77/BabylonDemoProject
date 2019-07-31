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
    let mockPersistantContainer = MockPersistantContainer()
    let contentStateViewModel = ContentStateViewModel()
    let properties = TestProperties()
    var convertedString = String()
    
    final class MockContentStateDelegate: ContentStateViewModelDelegate {
        var timesDidLoadDataCalled = 0
        var timesErrorCalled = 0
        
        func didUpdateWithData() {
            timesDidLoadDataCalled += 1
        }
        
        func didUpdateWithError(error: [Error]) {
            timesErrorCalled += 1
        }
    }

    override func setUp() {
        super.setUp()
        storageManager = StorageManager(persistentContainer: mockPersistantContainer.mockPersistantContainer)
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testLoad() {
        let postOne = self.properties.postItem()
        _ = self.storageManager.insertPostItem(posts: postOne)
        let mockAPI = MockAPI(isReturningError: false)
        let network = MockNetworkManager(networkManager: mockAPI)
        let mockSpy = MockContentStateDelegate()
        let contentStateViewModel = ContentStateViewModel()
        contentStateViewModel.delegate = mockSpy
        contentStateViewModel.loadManager = LoadManager(networkManager: network)
        let postsPath = URLEndpoint(path: Paths.postsUrlPath)
        contentStateViewModel.loadManager?.networkManager.fetchAPIData(with: postsPath, completion: { result in
            switch result {
            case let .failure(error):
            var errorsArray = [Error]()
            errorsArray.append(error)
            mockSpy.didUpdateWithError(error: errorsArray)
            case .success:
            mockSpy.didUpdateWithData()
            }
        })
        let post = storageManager.fetchAllPosts()

        XCTAssertEqual(post.count, 1)
        XCTAssertEqual(mockSpy.timesErrorCalled, 0)
        XCTAssertEqual(mockSpy.timesDidLoadDataCalled, 1)
    }
    
//    func testConvertLoclizedToString() {
//        let contentStateViewModel = ContentStateViewModel()
//        let spy = MockContentStateDelegate()
//        contentStateViewModel.delegate = spy
//        let mockAPI = MockAPI(isReturningError: true)
//        let saveData = NetworkManager(dataSource: mockAPI)
//        let path = URLEndpoint(path: Paths.postsUrlPath)
//        let string = """
//                    The operation couldn’t be completed. (BabylonDemoProject.DataSourceError error 1.) 
//
//                    """
//        saveData.fetchAPIData(with: path, completion: { result in
//            switch result {
//            case .failure(let error):
//                var errorArray = [Error]()
//                errorArray.append(error)
//                spy.didUpdateWithError(error: errorArray)
//                self.convertedString = contentStateViewModel.convertLoclizedToString(error: errorArray)
//            case .success:
//                spy.didUpdateWithData()
//            }
//        })
//        XCTAssertEqual(self.convertedString, string)
//    }
}
