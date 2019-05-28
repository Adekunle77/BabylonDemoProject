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

    var dataSource = HttpRequest()
    private var savedData: CoreDataSaveManager?
    
    init() {
        self.savedData = CoreDataSaveManager(dataSource: dataSource)
        savedData?.delegate = self
        fetchPostData()
        fetchAuthorData()
        fetchCommentData()
    }
    
    func fetchAuthorData() {
        if entityIsEmpty(entity: Author.self) {
            let path = URLEndpoint.init(path: Paths.authorUrlPath)
            savedData?.fetchAPIData(with: path)
        }
    }
    
    func fetchPostData() {
        if entityIsEmpty(entity: Posts.self) == true {
            let path = URLEndpoint.init(path: Paths.postsUrlPath)
            savedData?.fetchAPIData(with: path)
        }
    }
    
    func fetchCommentData() {
        if entityIsEmpty(entity: Comment.self) {
            let path = URLEndpoint.init(path: Paths.commentsUrlPath)
            savedData?.fetchAPIData(with: path)
        }
    }

    func CoreDataSavedAuthor() {
        NotificationCenter.default.post(name: didLoadAuthorInfoNotificationKey, object: nil)
    }

    func dataDidSaveComment() {
         NotificationCenter.default.post(name: didLoadCommentsNotificationKey, object: nil)
    }
    
    func dataDidSavePosts() {
        NotificationCenter.default.post(name: didLoadPostsNotificationKey, object: nil)
    }
    
    func dataSavingError(error: Error) {

        let coreDataError: [String: Error] = ["error": error]
        NotificationCenter.default.post(name: didLoadErrorNotificationKey, object: nil, userInfo: coreDataError)
    }
    
    private func entityIsEmpty<T: NSManagedObject>(entity: T.Type) -> Bool {
        let entityName = String(describing: entity)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let result = try PersistenceService.context.count(for: fetchRequest)
            if result == 0 {
                
                return true
            }
        } catch let error {
            self.dataSavingError(error: error)
        }
        return false
    }

}
