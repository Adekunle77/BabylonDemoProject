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
    let mockPersistantContainer = MockPersistantContainer()
    let properties = TestProperties()
    override func setUp() {
        super.setUp()
        storageManager = StorageManager(persistentContainer: mockPersistantContainer.mockPersistantContainer)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextSaved(notification:)),
                                               name: Notification.Name.NSManagedObjectContextDidSave,
                                               object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func testInsertPostItem() {
        let postOne = properties.postItem()
        let insert = storageManager.insertPostItem(posts: postOne)
        XCTAssertNotNil(insert)
    }
    func testInsertCommentItem() {
        let commentOne = properties.commentItem()
        let insert = storageManager.insertCommentItem(comment: commentOne)
        XCTAssertNotNil(insert)
    }
    func testInsertAuthorItem() {
        let authorOne = properties.authorItem()
        let insert = storageManager.insertAuthorItem(author: authorOne)
        XCTAssertNotNil(insert)
    }

    func testRemovePostsData() {
        let postOne = properties.postItem()
        _ = storageManager.insertPostItem(posts: postOne)
        let items = storageManager.fetchAllPosts()
        let item =  items[0]
        let numberOfItems = items.count
        storageManager.remove(objectID: item.objectID)
        try? storageManager.save()
        XCTAssertEqual(numberOfItemsInPostsPersistanceStore(), numberOfItems - 1)
    }

    func testRemoveCommentsData() {
        let commentOne = properties.commentItem()
        _ = storageManager.insertCommentItem(comment: commentOne)
        let items = storageManager.fetchAllComments()
        let item =  items[0]
        let numberOfItems = items.count
        storageManager.remove(objectID: item.objectID)
        try? storageManager.save()
        XCTAssertEqual(numberOfItemsInCommentsPersistanceStore(), numberOfItems - 1)
    }
    func testRemoveAuthorsData() {
        let authorOne = properties.authorItem()
        _ = storageManager.insertAuthorItem(author: authorOne)
        let items = storageManager.fetchAllAuthors()
        let item = items[0]
        let numberOfItems = items.count
        storageManager.remove(objectID: item.objectID)
        try? storageManager.save()
        XCTAssertEqual(numberOfItemsInAuthorsPersistanceStore(), numberOfItems - 1)
    }
    func testSave() {
        let postOne = properties.postItem()
        let expect = expectation(description: "Context Saved")
        waitForSavedNotification { _ in
            expect.fulfill()
        }
        _ = storageManager.insertPostItem(posts: postOne)
        try? storageManager.save()
        waitForExpectations(timeout: 1, handler: nil)
    }
    func numberOfItemsInPostsPersistanceStore() -> Int? {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Posts")
        let result = try? mockPersistantContainer.mockPersistantContainer.viewContext.fetch(request)
        return result?.count
    }
    func numberOfItemsInCommentsPersistanceStore() -> Int? {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Comment")
        let result = try? mockPersistantContainer.mockPersistantContainer.viewContext.fetch(request)
        return result?.count
    }
    func numberOfItemsInAuthorsPersistanceStore() -> Int? {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Author")
        let result = try? mockPersistantContainer.mockPersistantContainer.viewContext.fetch(request)
        return result?.count
    }
    func waitForSavedNotification(completeHandler: @escaping ((Notification) -> Void) ) {
        saveNotificationCompleteHandler = completeHandler
    }
    func contextSaved( notification: Notification ) {
        saveNotificationCompleteHandler?(notification)
    }
}
