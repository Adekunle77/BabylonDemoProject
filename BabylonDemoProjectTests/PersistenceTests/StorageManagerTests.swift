//
//  CoreDataManagerTests.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 28/06/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import XCTest
import CoreData
@testable import BabylonDemoProject

class StorageManagerTests: XCTestCase {
    var storageManager: StorageManager!
    var saveNotificationCompleteHandler: ((Notification) -> Void)?
    let mockPersistentContainer = MockPersistentContainer()
    let properties = TestProperties()
    override func setUp() {
        super.setUp()
        storageManager = StorageManager(persistentContainer: mockPersistentContainer.mockPersistentContainer)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextSaved(notification:)),
                                               name: Notification.Name.NSManagedObjectContextDidSave,
                                               object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func testInsertPostItem() {
        let post = properties.postItem()
        let insert = storageManager.insert(post)
        XCTAssertNotNil(insert)
    }
    func testInsertCommentItem() {
        let comment = properties.commentItem()
        let insert = storageManager.insert(comment)
        XCTAssertNotNil(insert)
    }
    func testInsertAuthorItem() {
        let author = properties.authorItem()
        let insert = storageManager.insert(author)
        XCTAssertNotNil(insert)
    }

    func testDeleteSavedData() {
        let post = properties.postItem()
        _ = storageManager.insert(post)
        let items = storageManager.fetchAllPosts()
        let numberOfItems = items.count
        do {
            try storageManager.deleteSavedData(with: Posts.self)
        } catch {
            print("error")
         XCTAssertEqual(numberOfItemsInPostsPersistanceStore(), numberOfItems - 1)
    }
}
    func testRemovePostsData() {
        let post = properties.postItem()
        _ = storageManager.insert(post)
        let items = storageManager.fetchAllPosts()
        let item =  items[0]
        let numberOfItems = items.count
        storageManager.remove(objectID: item.objectID)
        XCTAssertEqual(numberOfItemsInPostsPersistanceStore(), numberOfItems - 1)
    }

    func testRemoveCommentsData() {
        let comment = properties.commentItem()
        _ = storageManager.insert(comment)
        let items = storageManager.fetchAllComments()
        let item =  items[0]
        let numberOfItems = items.count
        storageManager.remove(objectID: item.objectID)
        XCTAssertEqual(numberOfItemsInCommentsPersistanceStore(), numberOfItems - 1)
    }
    func testRemoveAuthorsData() {
        let author = properties.authorItem()
        _ = storageManager.insert(author)
        let items = storageManager.fetchAllAuthors()
        let item = items[0]
        let numberOfItems = items.count
        storageManager.remove(objectID: item.objectID)
        XCTAssertEqual(numberOfItemsInAuthorsPersistanceStore(), numberOfItems - 1)
    }
    func testSave() {
        let post = properties.postItem()
        let expect = expectation(description: "Context Saved")
        waitForSavedNotification { _ in
            expect.fulfill()
        }
        _ = storageManager.insert(post)
        waitForExpectations(timeout: 1, handler: nil)
    }
    func numberOfItemsInPostsPersistanceStore() -> Int? {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Posts")
        let result = try? mockPersistentContainer.mockPersistentContainer.viewContext.fetch(request)
        return result?.count
    }
    func numberOfItemsInCommentsPersistanceStore() -> Int? {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Comment")
        let result = try? mockPersistentContainer.mockPersistentContainer.viewContext.fetch(request)
        return result?.count
    }
    func numberOfItemsInAuthorsPersistanceStore() -> Int? {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Author")
        let result = try? mockPersistentContainer.mockPersistentContainer.viewContext.fetch(request)
        return result?.count
    }
    func waitForSavedNotification(completeHandler: @escaping ((Notification) -> Void) ) {
        saveNotificationCompleteHandler = completeHandler
    }
    func contextSaved( notification: Notification ) {
        saveNotificationCompleteHandler?(notification)
    }
}
