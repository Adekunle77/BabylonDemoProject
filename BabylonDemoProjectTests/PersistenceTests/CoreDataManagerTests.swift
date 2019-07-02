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

class CoreDataManagerTests: XCTestCase {

    var coreDataManager: CoreDataManager!
    var saveNotificationCompleteHandler: ((Notification)->())?
    let mockPersistantContainer = MockPersistantContainer()
    let stubs = Stubs()
    override func setUp() {
        super.setUp()
        stubs.initAuthorStubs()
        stubs.initCommentStubs()
        stubs.initPostStubs()
        coreDataManager = CoreDataManager(persistentContainer: mockPersistantContainer.mockPersistantContainer)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextSaved(notification:)),
                                               name: Notification.Name.NSManagedObjectContextDidSave,
                                               object: nil)
    }

    override func tearDown() {
        NotificationCenter.default.removeObserver(self)
        stubs.removeAuthorData()
        stubs.removeCommentData()
        stubs.removePostsData()
        super.tearDown()
    }
    
    func testInsertPostItem() {
        let postOne = PostsModel(userId: 1, identification: 1, body: "Test body 1", title: "Post Title One")
        let insert = coreDataManager.insertPostItem(posts: postOne)
        XCTAssertNotNil(insert)
    }
    
    func testInsertCommentItem() {
        let commentOne = CommentModel(postId: 1,
                                      identification: 1,
                                      name: "Test Name 1",
                                      email: "testOne@babylondemo.com", body: "Comment Body One")
        let insert = coreDataManager.insertCommentItem(comment: commentOne)
        XCTAssertNotNil(insert)
    }    
    func testInsertAuthorItem() {
        let geo = Geo(latitude: "-37.3159", longitude: "81.1496")
        let address = Address(street: "Kulas Light", suite: "Apt. 556", city: "Gwenborough",
                              zipcode: "92998-3874",
                              geocode: geo)
        let company = Company(name: "Romaguera-Crona",
                              catchPhrase: "Multi-layered client-server neural-net",
                              bachelorScience: "harness real-time e-markets")
        let authorOne = AuthorModel(identification: 1,
                                    name: "Babylon Demo Project",
                                    username: "babylon1",
                                    email: "testOne@babylondemo.com",
                                    address: address, phone: "123",
                                    website: "www.babylon.com", company: company)
        let insert = coreDataManager.insertAuthorItem(author: authorOne)
        XCTAssertNotNil(insert)
    }
    
//    func testFetchAllPosts() {
//        let results = coreDataManager.fetchAllPosts()
//        XCTAssertEqual(results.count, 3)
//    }
//    func testFetchAllComents() {
//        let results = coreDataManager.fetchAllComments()
//        XCTAssertEqual(results.count, 3)
//    }
//    func testFetchAllAuthors() {
//        let results = coreDataManager.fetchAllAuthors()
//        XCTAssertEqual(results.count, 3)
//    }
    func testRemovePostsData() {
        let postOne = PostsModel(userId: 1, identification: 1, body: "Test body 1", title: "Post Title One")
        _ = coreDataManager.insertPostItem(posts: postOne)
        let items = coreDataManager.fetchAllPosts()
        let item =  items[0]
        let numberOfItems = items.count
        coreDataManager.remove(objectID: item.objectID)
        do {
            try coreDataManager.save()
        } catch {
            print(error)
        }
        XCTAssertEqual(numberOfItemsInPostsPersistanceStore(), numberOfItems - 1)
    }
    func numberOfItemsInPostsPersistanceStore() -> Int? {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Posts")
        let result = try? mockPersistantContainer.mockPersistantContainer.viewContext.fetch(request)
        return result?.count
    }
    func testRemoveCommentsData() {
        let commentOne = CommentModel(postId: 1,
                                      identification: 1,
                                      name: "Test Name 1",
                                      email: "testOne@babylondemo.com", body: "Comment Body One")
        _ = coreDataManager.insertCommentItem(comment: commentOne)
        let items = coreDataManager.fetchAllComments()
        let item =  items[0]
        let numberOfItems = items.count
        coreDataManager.remove(objectID: item.objectID)
        do {
            try coreDataManager.save()
        } catch {
           print(error)
        }
        XCTAssertEqual(numberOfItemsInCommentsPersistanceStore(), numberOfItems - 1)
    }
    func numberOfItemsInCommentsPersistanceStore() -> Int? {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Comment")
        let result = try? mockPersistantContainer.mockPersistantContainer.viewContext.fetch(request)
        return result?.count
    }
    func testRemoveAuthorsData() {
        let geo = Geo(latitude: "-37.3159", longitude: "81.1496")
        let address = Address(street: "Kulas Light", suite: "Apt. 556", city: "Gwenborough",
                              zipcode: "92998-3874",
                              geocode: geo)
        let company = Company(name: "Romaguera-Crona",
                              catchPhrase: "Multi-layered client-server neural-net",
                              bachelorScience: "harness real-time e-markets")
        let authorOne = AuthorModel(identification: 1,
                                    name: "Babylon Demo Project",
                                    username: "babylon1",
                                    email: "testOne@babylondemo.com",
                                    address: address, phone: "123",
                                    website: "www.babylon.com", company: company)
        _ = coreDataManager.insertAuthorItem(author: authorOne)
        let items = coreDataManager.fetchAllAuthors()
        let item = items[0]
        let numberOfItems = items.count
        coreDataManager.remove(objectID: item.objectID)
        do {
            try coreDataManager.save()
        } catch {
            print(error)
        }
        XCTAssertEqual(numberOfItemsInAuthorsPersistanceStore(), numberOfItems - 1)
    }
    func numberOfItemsInAuthorsPersistanceStore() -> Int? {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Author")
        let result = try? mockPersistantContainer.mockPersistantContainer.viewContext.fetch(request)
        return result?.count
    }
    func testSave() {
        
        let postOne = PostsModel(userId: 1, identification: 1, body: "Test body 1", title: "Post Title One")
        
        let expect = expectation(description: "Context Saved")
        
        waitForSavedNotification { (notification) in
            expect.fulfill()
        }
        _ = coreDataManager.insertPostItem(posts: postOne)
        do {
            try coreDataManager.save()
        } catch {
            print(error)
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func waitForSavedNotification(completeHandler: @escaping ((Notification)->()) ) {
        saveNotificationCompleteHandler = completeHandler
    }
    func contextSaved( notification: Notification ) {
        saveNotificationCompleteHandler?(notification)
    }
}
