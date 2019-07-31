//
//  MockAPI.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 13/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

@testable import BabylonDemoProject
import Foundation

class MockNetworkManager: Network {
    let networkManager: MockAPI?
    var coreDataManager: StorageManager!
    let mockPersistantContainer = MockPersistantContainer()

    init(networkManager: MockAPI) {
        self.networkManager = networkManager
        coreDataManager = StorageManager(persistentContainer: mockPersistantContainer.mockPersistantContainer)
    }
    
    func fetchAPIData(with path: URLEndpoint, completion: @escaping (Result<(), DataSourceError>) -> Void) {
        networkManager?.fetchJsonData(endPoint: path, completion: { [weak self] result in
            switch result {
            case let .failure(error):
                completion(Result.failure(.network(error)))
            case let .success(data):
                switch data {
                case let .authors(authors):
                    for author in authors {
                        _ = self?.coreDataManager.insertAuthorItem(author: author)
                        self?.coreDataManager?.save()
                    }
                case let .comments(comments):
                    for comment in comments {
                        _ = self?.coreDataManager.insertCommentItem(comment: comment)
                        self?.coreDataManager?.save()
                    }
                case let .posts(posts):
                    for post in posts {
                        _ = self?.coreDataManager.insertPostItem(posts: post)
                        self?.coreDataManager?.save()
                    }
                }
                 completion(.success(()))
            }
        })
    }
}

class MockAPI: API {
    var isReturningError: Bool
    let properties = TestProperties()
    init(isReturningError: Bool) {
        self.isReturningError = isReturningError
    }

    func fetchJsonData(endPoint: URLEndpoint, completion: @escaping CompletionHandler) {
        if isReturningError {
            completion(.failure(DataSourceError.noData))
        } else {
            if endPoint.path == .authorUrlPath {
                let authors = [properties.authorItem()]
                completion(.success(.authors(authors)))
            }
            if endPoint.path == .commentsUrlPath {
                let comments = [properties.commentItem()]
                completion(.success(.comments(comments)))
            }
            if endPoint.path == .postsUrlPath {
                let posts = [properties.postItem()]
                completion(.success(.posts(posts)))
            }
        }
    }
}
