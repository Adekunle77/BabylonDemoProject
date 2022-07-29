//
//  NetworkManager.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 11/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

final internal class PersistedContentProvider: ContentProvider {
    private let dataSource: ContentProvider
    private let storageManager: MutableContentStore?

    init(dataSource: ContentProvider) {
        storageManager = StorageManager(persistentContainer: PersistenceService.persistentContainer)
        self.dataSource = dataSource
    }

    func fetch(_ type: ContentType, completion: @escaping PersistedContentProvider.Completion) {

        dataSource.fetch(type, completion: { [weak self] result in
            if case let .success(collection) = result { self?.insert(collection) }
            completion(result)
        })
    }

    private func insert(_ collection: ModelCollection) {
        switch collection {
        case let .users(author):
            self.insert(authors: author)
        case let .comments(comment):
            self.insert(comments: comment)
        case let .posts(post):
            self.insert(posts: post)
        }
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

extension PersistedContentProvider: ContentStore {
    func fetchAllPosts() -> [Posts] {
        return self.storageManager?.fetchAllPosts() ?? []
    }

    func fetchAllComments() -> [Comment] {
        return self.storageManager?.fetchAllComments() ?? []
    }

    func fetchAllAuthors() -> [Author] {
        return self.storageManager?.fetchAllAuthors() ?? []
    }
}
