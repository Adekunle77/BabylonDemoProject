//
//  LoadingViewModel.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import CoreData
import Foundation
import UIKit

protocol ViewModelDelegate: class {
    func modelDidUpdateWithData()
    func modelDidUpdateWithError(error: Error)
    func showPostDetails(post: PostTuple)
}

typealias PostTuple = (author: Author, post: Posts, commentsCount: String)

class PostsViewModel: NSObject {
    weak var delegate: ViewModelDelegate?
    var storageManager: StorageManager

    override init() {
        storageManager = StorageManager(persistentContainer: PersistenceService.persistentContainer)
        super.init()
    }

    private func getCommentsCount(using post: Posts, with array: [Comment]) -> String {
        let userID = post.postId
        let comments = array.all(where: { $0.postId == userID })
        return String(comments.count)
    }

    private func getAuthorInfo(using title: Posts, with array: [Author]) -> Author {
        let userID = title.userID
        var author = Author(context: PersistenceService.context)
        if let identification = array.first(where: { $0.authorID == userID }) {
            author = identification
        }
        return author
    }

    func refreshData() {
//        let posts = storageManager.fetchAllPosts()
//        for post in posts {
//            storageManager.remove(objectID: post.objectID)
//        }
//        let comments = storageManager.fetchAllPosts()
//        for comment in comments {
//            storageManager.remove(objectID: comment.objectID)
//        }
//        let authors = storageManager.fetchAllPosts()
//        for author in authors {
//            storageManager.remove(objectID: author.objectID)
//        }
       // storageManager.save()
        do {
            try storageManager.deleteSavedData(with: Posts.self)
            try storageManager.deleteSavedData(with: Author.self)
            try storageManager.deleteSavedData(with: Comment.self)
            delegate?.modelDidUpdateWithData()
        } catch {
            delegate?.modelDidUpdateWithError(error: error)
        }
    }
}

extension PostsViewModel: UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        let posts = storageManager.fetchAllPosts()
        return posts.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            CollectionViewCell.reuseIdentifier,
            for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        let posts = storageManager.fetchAllPosts()
        let post = posts
        let info = post[indexPath.item]
        cell.updateCell(with: info)
        return cell
    }
}

extension PostsViewModel: UICollectionViewDelegate {
    func collectionView(_: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let posts = storageManager.fetchAllPosts()
        let postInfo = posts[indexPath.item]
        let authors = storageManager.fetchAllAuthors()
        let author = getAuthorInfo(using: postInfo, with: authors)
        let comments = storageManager.fetchAllComments()
        let commentCount = getCommentsCount(using: postInfo, with: comments)
        delegate?.showPostDetails(post: (
            author: author, post: postInfo, commentsCount: commentCount
        ))
    }
}

#if DEBUG
extension PostsViewModel {
    func testGetCommentsCount(using post: Posts, with array: [Comment]) -> String {
        let testObject = getCommentsCount(using: post, with: array)
        return testObject
    }

    func testGetAuthorInfo(using title: Posts, with array: [Author]) -> Author {
        let testObject = getAuthorInfo(using: title, with: array)
        return testObject
    }
}
#endif
