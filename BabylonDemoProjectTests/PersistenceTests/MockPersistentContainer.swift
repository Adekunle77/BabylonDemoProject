//
//  MockPersistentContainer.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 28/06/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import CoreData
@testable import BabylonDemoProject

class MockPersistentContainer {
    lazy var mockPersistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BabylonDemoProject",
                                              managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        container.persistentStoreDescriptions = [description]
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
}
