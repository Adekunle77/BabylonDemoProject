//
//  MockAPI.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 13/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

@testable import BabylonDemoProject
import Foundation

final class MockNetworkManager: Network {
    let networkManager: MockAPI?
    var coreDataManager: StorageManager!
    let mockPersistentContainer = MockPersistentContainer()

    init(networkManager: MockAPI) {
        self.networkManager = networkManager
        coreDataManager = StorageManager(persistentContainer: mockPersistentContainer.mockPersistentContainer)
    }

    func fetchAPIData(with path: ContentType, completion: @escaping (Result<(), DataSourceError>) -> Void) {
        networkManager?.fetch(_ contentType: path, completion: { [weak self] result in
            switch result {
            case let .failure(error):
                completion(Result.failure(.network(error)))
            case let .success(data):
                switch data {
                case let .users(authors):
                    for author in authors {
                        _ = self?.coreDataManager.insert(author)
                    }
                case let .comments(comments):
                    for comment in comments {
                        _ = self?.coreDataManager.insert(comment)
                    }
                case let .posts(posts):
                    for post in posts {
                        _ = self?.coreDataManager.insert(post)
                    }
                }
                 completion(.success(()))
            }
        })
    }
}

final class MockAPI: ContentProvider {
    var isReturningError: Bool
    let properties = TestProperties()
    init(isReturningError: Bool) {
        self.isReturningError = isReturningError
    }

    func fetch(_ contentType: ContentType, completion: @escaping CompletionHandler) {
        if isReturningError {
            completion(.failure(DataSourceError.noData))
        } else {
            if _ contentType.rawValue == ContentType.users.rawValue {
                let authors = [properties.authorItem()]
                completion(.success(.users(authors)))
            }
            if _ contentType.rawValue == ContentType.comments.rawValue {
                let comments = [properties.commentItem()]
                completion(.success(.comments(comments)))
            }
            if _ contentType.rawValue == ContentType.posts.rawValue {
                let posts = [properties.postItem()]
                completion(.success(.posts(posts)))
            }
        }
    }
}
