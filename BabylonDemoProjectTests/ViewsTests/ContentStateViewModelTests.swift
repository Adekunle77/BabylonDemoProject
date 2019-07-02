//
//  ContentStateViewModelTests.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 18/06/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

@testable import BabylonDemoProject
import XCTest

class ContentStateViewModelTests: XCTestCase {
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
    var postsArray = [Posts]()
    var mockAPI = MockAPI()
    weak var delegate: CoreDataLoadManagerDelegateSpy?
    //let saveData: CoreDataSaveManager
    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testGetPostDidRecieveError() {
        mockAPI.isReturningError = true
        //let saveData = CoreDataSaveManager
        let contentStateViewModel = ContentStateViewModel()
        
    }
    
  //  func //
}
