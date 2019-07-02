//
//  MockPersistantContainer.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 28/06/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import CoreData
@testable import BabylonDemoProject

class MockPersistantContainer {
    lazy var mockPersistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BabylonDemoProject",
                                              managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        container.persistentStoreDescriptions = [description]
        print("test 5")
        container.loadPersistentStores {(description, error) in
            precondition(description.type == NSInMemoryStoreType)
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()
    
    
//    lazy var managedObjectModel: NSManagedObjectModel = {
//        let managedObjectModel = NSManagedObjectModel.mergedModel(
//            from: [Bundle(for: type(of: self))])!
//        return managedObjectModel
//    }()
}
