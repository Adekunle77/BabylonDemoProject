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

final class NetworkManager: Network {
    let dataSource: API
    private let storageManager: StorageManager?

    init(dataSource: API) {
        storageManager = StorageManager(persistentContainer: PersistenceService.persistentContainer)
        self.dataSource = dataSource
    }

    func fetchAPIData(with path: URLEndpoint, completion: @escaping (Result<(), DataSourceError>) -> Void) {
        dataSource.fetchJSONData(endpoint: path, completion: { [weak self] result in
            switch result {
            case let .failure(error):
                completion(.failure(.network(error)))
            case let .success(data):
                switch data {
                case let .users(author):
                    self?.insert(authors: author)
                case let .comments(comment):
                    self?.insert(comments: comment)
                case let .posts(post):
                    self?.insert(posts: post)
                }
                completion(.success(()))
            }
        })
    }

    private func insert(posts: [PostsModel]) {
        for post in posts {
            _ = storageManager?.insert(post)
        }
    }

    private func insert(authors: [UserModel]) {
        for author in authors {
            _ = storageManager?.insert(author)
        }
    }

    private func insert(comments: [CommentModel]) {
        for comment in comments {
            _ = storageManager?.insert(comment)
        }
    }
}
