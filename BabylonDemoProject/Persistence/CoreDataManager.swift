//
//  CoreDataManager.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 28/06/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer!
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    convenience init() {
        self.init(persistentContainer: PersistenceService.persistentContainer)
    }
    func insertPostItem(posts: PostsModel) -> Posts? {
        guard let postEntity = NSEntityDescription.insertNewObject(
            forEntityName: "Posts",
            into: persistentContainer.viewContext) as? Posts else { return nil }
        postEntity.body = posts.body
        postEntity.title = posts.title
        postEntity.postId = Int16(posts.identification)
        postEntity.userID = Int16(posts.userId)
        print(postEntity, "test test test")
        return postEntity
    }
    func insertCommentItem(comment: CommentModel) -> Comment? {
        guard let commentEntity = NSEntityDescription.insertNewObject(
            forEntityName: "Comment",
            into: persistentContainer.viewContext) as? Comment else { return nil }
        commentEntity.commentId = Int16(comment.identification)
        commentEntity.comments = comment.body
        commentEntity.postId = Int16(comment.postId)
        return commentEntity
    }
    func insertAuthorItem(author: AuthorModel) -> Author? {
        guard let authorEntity = NSEntityDescription.insertNewObject(
            forEntityName: "Author",
            into: persistentContainer.viewContext) as? Author else { return nil }
        authorEntity.name = author.name
        authorEntity.authorID = Int16(author.identification)
        return authorEntity
    }
    func fetchAllPosts() -> [Posts] {
        let request: NSFetchRequest<Posts> = Posts.fetchRequest()
        let result = try? persistentContainer.viewContext.fetch(request)
        
        return result ?? [Posts]()
    }
    func fetchAllComments() -> [Comment] {
        let request: NSFetchRequest<Comment> = Comment.fetchRequest()
        let result = try? persistentContainer.viewContext.fetch(request)
        return result ?? [Comment]()
    }
    func fetchAllAuthors() -> [Author] {
        let request: NSFetchRequest<Author> = Author.fetchRequest()
        let result = try? persistentContainer.viewContext.fetch(request)
        return result ?? [Author]()
    }
    func remove(objectID: NSManagedObjectID) {
        let objcet = persistentContainer.viewContext.object(with: objectID)
        persistentContainer.viewContext.delete(objcet)
    }
    func save() throws {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                throw error
            }
        }
    }
}
