//
//  Stubs.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 28/06/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import CoreData
@testable import BabylonDemoProject

class Stubs {
    private let mockContainer = MockPersistantContainer()
    let properties = TestProperties()
    func initPostStubs() {
        func insertPostItem(post: PostsModel) -> Posts? {
            let object = NSEntityDescription.insertNewObject(forEntityName: "Posts", into: mockContainer.mockPersistantContainer.viewContext)
            object.setValue("Test body 1", forKey: "body")
            object.setValue(Int16(1), forKey: "postId")
            object.setValue(Int16(1), forKey: "userID")
            object.setValue("Post Title One", forKey: "title")
            return object as? Posts
        }
        let postOne = PostsModel(userId: 1, identification: 1, body: "Test body 1", title: "Post Title One")
        let postTwo = PostsModel(userId: 2, identification: 2, body: "Test body 2", title: "Post Title Two")
        let postThree = PostsModel(userId: 3, identification: 3, body: "Test body 2", title: "Post Title Three")
        
        
        _ = insertPostItem(post: postOne)
        _ = insertPostItem(post: postTwo)
        _ = insertPostItem(post: postThree)
        do {
            print("save")
            try mockContainer.mockPersistantContainer.viewContext.save()
        } catch {
            print("create fakes error \(error)")
        }
    }
    func initCommentStubs() {
        func insertCommentItem(comment: CommentModel) -> Comment? {
            let object = NSEntityDescription.insertNewObject(forEntityName: "Comment", into: mockContainer.mockPersistantContainer.viewContext)
            object.setValue(Int16(comment.identification), forKey: "commentId")
            object.setValue(Int16(comment.postId), forKey: "postId")
            object.setValue(comment.body, forKey: "comments")
            return object as? Comment
        }
        let commentOne = CommentModel(postId: 1,
                                      identification: 1,
                                      name: "Test Name 1",
                                      email: "testOne@babylondemo.com", body: "Comment Body One")
        let commentTwo = CommentModel(postId: 2,
                                      identification: 2,
                                      name: "Test Name 2",
                                      email: "testTwo@babylondemo.com", body: "Comment Body Two")
        let commentThree = CommentModel(postId: 3,
                                        identification: 3, name: "Test Name 3",
                                        email: "testThree@babylondemo.com", body: "Comment Body Three")
        _ = insertCommentItem(comment: commentOne)
        _ = insertCommentItem(comment: commentTwo)
        _ = insertCommentItem(comment: commentThree)
        do {
            try mockContainer.mockPersistantContainer.viewContext.save()
        } catch {
            print("create fakes error \(error)")
        }
    }
    func initAuthorStubs() {
        func insertAuthorItem(author: AuthorModel) -> Author? {
             let object = NSEntityDescription.insertNewObject(forEntityName: "Author",
                                                              into: mockContainer.mockPersistantContainer.viewContext)
            object.setValue(author.name, forKey: "name")
            object.setValue(Int16(author.identification), forKey: "authorID")
            return object as? Author
        }
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
        _ = insertAuthorItem(author: authorOne)
        do {
            print("save")
            try mockContainer.mockPersistantContainer.viewContext.save()
        } catch {
            print("create fakes error \(error)")
        }
    }
    func removePostsData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> =
            NSFetchRequest<NSFetchRequestResult>(entityName: "Posts")
        guard let objects = try? mockContainer.mockPersistantContainer.viewContext.fetch(fetchRequest) else { return }
        for case let object as NSManagedObject in objects {
            mockContainer.mockPersistantContainer.viewContext.delete(object)
        }
        try? mockContainer.mockPersistantContainer.viewContext.save()
    }
    func removeCommentData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> =
            NSFetchRequest<NSFetchRequestResult>(entityName: "Comment")
        guard let objects = try? mockContainer.mockPersistantContainer.viewContext.fetch(fetchRequest) else { return }
        for case let object as NSManagedObject in objects {
            mockContainer.mockPersistantContainer.viewContext.delete(object)
        }
        try? mockContainer.mockPersistantContainer.viewContext.save()
    }
    func removeAuthorData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> =
            NSFetchRequest<NSFetchRequestResult>(entityName: "Author")
        guard let objects = try? mockContainer.mockPersistantContainer.viewContext.fetch(fetchRequest) else { return }
        for case let object as NSManagedObject in objects {
            mockContainer.mockPersistantContainer.viewContext.delete(object)
        }
        try? mockContainer.mockPersistantContainer.viewContext.save()
    }
}
