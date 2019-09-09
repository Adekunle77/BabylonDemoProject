//
//  StorageManager.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 28/06/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import CoreData

final class StorageManager {
    private let persistentContainer: NSPersistentContainer
    private lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }

    func insert(_ post: PostsModel) -> Posts? {
        guard let postEntity = NSEntityDescription.insertNewObject(
            forEntityName: "Posts",
            into: persistentContainer.viewContext) as? Posts else { return nil }
        postEntity.body = post.body
        postEntity.title = post.title
        postEntity.postId = Int16(post.identification)
        postEntity.userID = Int16(post.userId)
        self.save()
        return postEntity
    }

    func insert(_ comment: CommentModel) -> Comment? {
        guard let commentEntity = NSEntityDescription.insertNewObject(
            forEntityName: "Comment",
            into: persistentContainer.viewContext) as? Comment else { return nil }
        commentEntity.commentId = Int16(comment.identification)
        commentEntity.comments = comment.body
        commentEntity.postId = Int16(comment.postId)
        self.save()
        return commentEntity
    }

    func insert(_ author: UserModel) -> Author? {
        guard let authorEntity = NSEntityDescription.insertNewObject(
            forEntityName: "Author",
            into: persistentContainer.viewContext) as? Author else { return nil }
        authorEntity.name = author.name
        authorEntity.authorID = Int16(author.identification)
        self.save()
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

    func deleteSavedData<T: NSManagedObject>(with objectType: T.Type) {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? PersistenceService.context.execute(deleteRequest) 
        self.save()
    }

    func remove(objectID: NSManagedObjectID) {
        let objcet = persistentContainer.viewContext.object(with: objectID)
        persistentContainer.viewContext.delete(objcet)
        self.save()
    }

    private func save() {
        if persistentContainer.viewContext.hasChanges {
            try? persistentContainer.viewContext.save()
        }
    }
}
