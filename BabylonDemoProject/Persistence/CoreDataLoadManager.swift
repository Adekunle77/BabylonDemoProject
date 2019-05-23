//
//  LoadData.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 12/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import CoreData

class CoreDataLoadManager: SaveDataDelegate {
    
    var author = [Author(context: PersistenceService.context)]
    var posts = [Posts(context: PersistenceService.context)]
    var comment = [Comment(context: PersistenceService.context)]
    
    var dataSource = HttpRequest()
    private var savedData: CoreDataSaveManager?
    
    init() {
        self.savedData = CoreDataSaveManager(dataSource: dataSource)
        savedData?.delegate = self
        fetchPostData()
        print(posts.count)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func CoreDataSavedAuthor() {
        NotificationCenter.default.post(name: didLoadAuthorInfoNotificationKey, object: nil)
//        let fetchRequest: NSFetchRequest<Author> = Author.fetchRequest()
//        do {
//            let author = try PersistenceService.context.fetch(fetchRequest)
//            author.forEach({self.author.append($0)})
//
//        } catch let error {
//            self.dataSavingError(error: error)
//        }
    }

    func dataDidSaveComment() {
         NotificationCenter.default.post(name: didLoadCommentsNotificationKey, object: nil)
//        let fetchRequest: NSFetchRequest<Comment> = Comment.fetchRequest()
//        do {
//            let comment = try PersistenceService.context.fetch(fetchRequest)
//            comment.forEach({self.comment.append($0)})
//
//        } catch let error {
//            self.dataSavingError(error: error)
//        }
    }
    
    func dataDidSaveTitle() {
        NotificationCenter.default.post(name: didLoadPostsNotificationKey, object: nil)
//        let fetchRequest: NSFetchRequest<Posts> = Posts.fetchRequest()
//        do {
//            let title = try PersistenceService.context.fetch(fetchRequest)
//            title.forEach({self.posts.append($0)})
//
//        } catch let error {
//            self.dataSavingError(error: error)
//        }
    }
    
    func dataSavingError(error: Error) {
        let coreDataError: [String: Error] = ["error": error]
        NotificationCenter.default.post(name: didLoadErrorNotificationKey, object: nil, userInfo: coreDataError)
    }
    
     func fetchAuthorData() {
        if author.isEmpty {
            let path = URLEndpoint.init(path: Paths.authorUrlPath)
            savedData?.fetchAPIData(with: path)
        }
    }
    
     func fetchPostData() {
        if posts.isEmpty {
            let path = URLEndpoint.init(path: Paths.titleUrlPath)
            savedData?.fetchAPIData(with: path)
        }
    }
    
     func fetchCommentData() {
        if comment.isEmpty {
            let path = URLEndpoint.init(path: Paths.commentsUrlPath)
            savedData?.fetchAPIData(with: path)
        }
    }
 
//    func checkDataIsAvailable() -> Bool {
//        if posts.isEmpty && entityIsEmpty(entity: "Posts") == false {
//            return true
//        }
//        return false
//    }
//
    
    private func entityIsEmpty(entity: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        do {
            let result = try PersistenceService.context.count(for: fetchRequest)
            if result == 0 {
                return false
            }
        } catch let error {
            self.dataSavingError(error: error)
        }
        return true
    }
    
    func refreshData() {
  
            self.author.forEach({PersistenceService.context.delete($0)})
            self.comment.forEach({PersistenceService.context.delete($0)})
            self.posts.forEach({PersistenceService.context.delete($0)})
            PersistenceService.saveContext()
    }
    
}
