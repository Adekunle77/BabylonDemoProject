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

    func fetchAPIData(with path: URLEndpoint, completion: @escaping (Result<(), DataSourceError>) -> Void) {
        networkManager?.fetchJSONData(endpoint: path, completion: { [weak self] result in
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

final class MockAPI: API {
    var isReturningError: Bool
    let properties = TestProperties()
    init(isReturningError: Bool) {
        self.isReturningError = isReturningError
    }

    func fetchJSONData(endpoint: URLEndpoint, completion: @escaping CompletionHandler) {
        if isReturningError {
            completion(.failure(DataSourceError.noData))
        } else {
            if endpoint.rawValue == URLEndpoint.users.rawValue {
                let authors = [properties.authorItem()]
                completion(.success(.users(authors)))
            }
            if endpoint.rawValue == URLEndpoint.comments.rawValue {
                let comments = [properties.commentItem()]
                completion(.success(.comments(comments)))
            }
            if endpoint.rawValue == URLEndpoint.posts.rawValue {
                let posts = [properties.postItem()]
                completion(.success(.posts(posts)))
            }
        }
    }
}
