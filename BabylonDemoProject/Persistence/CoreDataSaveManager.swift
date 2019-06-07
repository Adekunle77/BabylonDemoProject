//
//  PersistenceService.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 11/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import CoreData

class CoreDataSaveManager {
    let dataSource: API
    init(dataSource: API) {
        self.dataSource = dataSource
    }

    func fetchAPIData(with path: URLEndpoint, completion: @escaping (Result<(), DataSourceError>) -> ()) {
        
        dataSource.fetchJSONdata(endPoint: path, completion: {[weak self] result in
            switch result {
            case .failure(let error):
                completion(.failure(.dataError(error)))
            case .success(let data):
                switch data {
                case .authors(let author):                    
                    self?.saveAuthorData(with: author)
                case .comments(let comment):
                    self?.saveCommentData(with: comment)
                case .posts(let post):
                    self?.savePostData(with: post)
                }
               completion(.success(()))
            }
        })
    }
    
    
    func savePostData(with dataArray: [PostsModel]) {
        for item in dataArray {
            let title = Posts(context: PersistenceService.context)
            title.title = item.title
            title.body = item.body
            title.id = Int16(item.id)
            title.userID = Int16(item.userId)
            PersistenceService.saveContext()
        }
    }
    
    private func saveAuthorData(with dataArray: [AuthorModel]) {
        for item in dataArray {
            let author = Author(context: PersistenceService.context)
            author.name = item.name
            author.authorID = Int16(item.id)
            PersistenceService.saveContext()
        }
    }
    
    private func saveCommentData(with dataArray: [CommentModel]) {
        for item in dataArray {
            let comment = Comment(context: PersistenceService.context)
            comment.comments = item.body
            comment.postId = Int16(item.postId)
            comment.id = Int16(item.id)
            PersistenceService.saveContext()
        }
    }
    
}
    
    

