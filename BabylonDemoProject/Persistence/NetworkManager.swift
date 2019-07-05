//
//  NetworkManager.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 11/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import CoreData
import Foundation

protocol Network {
    func fetchAPIData(with path: URLEndpoint, completion: @escaping (Result<(), DataSourceError>) -> Void)
}

class NetworkManager: Network {
    let dataSource: API
    private let coreDataManager: StorageManager?
    init(dataSource: API) {
        coreDataManager = StorageManager(persistentContainer: PersistenceService.persistentContainer)
        self.dataSource = dataSource
    }

    func fetchAPIData(with path: URLEndpoint, completion: @escaping (Result<(), DataSourceError>) -> Void) {
        dataSource.fetchJsonData(endPoint: path, completion: { [weak self] result in
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
            _ = coreDataManager?.insertPostItem(posts: item)
            coreDataManager?.save()
        }
    }

    private func saveAuthorData(with dataArray: [AuthorModel]) {
        for item in dataArray {
            _ = coreDataManager?.insertAuthorItem(author: item)
            coreDataManager?.save()
        }
    }

    private func saveCommentData(with dataArray: [CommentModel]) {
        for item in dataArray {
            _ = coreDataManager?.insertCommentItem(comment: item)
            coreDataManager?.save()
        }
    }
}
