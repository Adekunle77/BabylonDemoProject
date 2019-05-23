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
    
    var author = Set<Author>()
    var posts = Set<Posts>()
    var comment = Set<Comment>()
    
    var dataSource = HttpRequest()
    private var savedData: CoreDataSaveManager?
    
    init() {

        self.savedData = CoreDataSaveManager(dataSource: dataSource)
        savedData?.delegate = self

//        fetchAuthorData()
//        fetchCommentData()
        fetchTitleData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func CoreDataSavedAuthor() {
        let fetchRequest: NSFetchRequest<Author> = Author.fetchRequest()
        do {
            let author = try PersistenceService.context.fetch(fetchRequest)
            author.forEach({self.author.insert($0)})
            NotificationCenter.default.post(name: didLoadAuthorInfoNotificationKey, object: nil)
        } catch let error {
            self.dataSavingError(error: error)
        }
    }

    func dataDidSaveComment() {
        let fetchRequest: NSFetchRequest<Comment> = Comment.fetchRequest()
        do {
            let comment = try PersistenceService.context.fetch(fetchRequest)
            print(comment.count, "dataDidSaveComment")
            comment.forEach({self.comment.insert($0)})
            NotificationCenter.default.post(name: didLoadCommentsNotificationKey, object: nil)
        } catch let error {
            self.dataSavingError(error: error)
        }
    }
    
    func dataDidSaveTitle() {
        let fetchRequest: NSFetchRequest<Posts> = Posts.fetchRequest()
        do {
            let title = try PersistenceService.context.fetch(fetchRequest)
            title.forEach({self.posts.insert($0)})
            NotificationCenter.default.post(name: didLoadPostsNotificationKey, object: nil)
        } catch let error {
            self.dataSavingError(error: error)
        }
    }
    
    func dataSavingError(error: Error) {
        //NotificationCenter.default.post(name: didLoadErrorNotificationKey, object: nil)
        let coreDataError: [String: Error] = ["error": error]
        NotificationCenter.default.post(name: didLoadErrorNotificationKey, object: nil, userInfo: coreDataError)
    }
    
     func fetchAuthorData() {
        if author.isEmpty {
            let path = URLEndpoint.init(path: Paths.authorUrlPath)
            savedData?.fetchAPIData(with: path)
        }
    }
    
     func fetchTitleData() {
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
    

    // fetchCommentData() functions needs to be recalled again, after refreshing 
    func refreshData() {
        //TODO: Make safe
        if posts.isEmpty && comment.isEmpty && author.isEmpty != false {
            self.author.forEach({PersistenceService.context.delete($0)})
            self.comment.forEach({PersistenceService.context.delete($0)})
            self.posts.forEach({PersistenceService.context.delete($0)})
            PersistenceService.saveContext()
        }
    }
    
}
