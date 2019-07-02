//
//  PersistenceService.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 11/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import CoreData
import Foundation

class SaveManager {
    let dataSource: API
    init(dataSource: API) {
        self.dataSource = dataSource
    }

    func fetchAPIData(with path: URLEndpoint, completion: @escaping (Result<(), DataSourceError>) -> Void) {
        dataSource.fetchJSONdata(endPoint: path, completion: { [weak self] result in
            switch result {
            case let .failure(error):
                completion(.failure(.network(error)))
            case let .success(data):
                switch data {
                case let .authors(author):
                    self?.saveAuthorData(with: author)
                case let .comments(comment):
                    self?.saveCommentData(with: comment)
                case let .posts(post):
                    self?.savePostData(with: post)
                }
                completion(.success(()))
            }
        })
    }

    func savePostData(with dataArray: [PostsModel]) {
        for item in dataArray {
            let post = Posts(context: PersistenceService.context)
            post.title = item.title
            post.body = item.body
            post.postId = Int16(item.identification)
            post.userID = Int16(item.userId)
            PersistenceService.saveContext()
        }
    }

    private func saveAuthorData(with dataArray: [AuthorModel]) {
        for item in dataArray {
            let author = Author(context: PersistenceService.context)
            author.name = item.name
            author.authorID = Int16(item.identification)
            PersistenceService.saveContext()
        }
    }

    private func saveCommentData(with dataArray: [CommentModel]) {
        for item in dataArray {
            let comment = Comment(context: PersistenceService.context)
            comment.comments = item.body
            comment.postId = Int16(item.postId)
            comment.commentId = Int16(item.identification)
            PersistenceService.saveContext()
        }
    }
}
