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
    let reuseIdentifier = "Cell"
    var postsArray = [Posts]()
    var authorsArray = [Author]()
    var commentsArray = [Comment]()

    private func fetchSavedCoreData<T: NSManagedObject>(with objectType: T.Type) -> [T] {
        var data = [T]()
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let fetchObject = try PersistenceService.context.fetch(fetchRequest) as? [T]
            data = fetchObject ?? [T]()
        } catch {
            delegate?.modelDidUpdateWithError(error: error)
        }
        return data
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
        deleteSavedCoreData(with: Posts.self)
        deleteSavedCoreData(with: Author.self)
        deleteSavedCoreData(with: Comment.self)
        delegate?.modelDidUpdateWithData()
    }

    private func deleteSavedCoreData<T: NSManagedObject>(with objectType: T.Type) {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try PersistenceService.context.execute(deleteRequest)
            PersistenceService.saveContext()
        } catch {
            delegate?.modelDidUpdateWithError(error: error)
        }
    }
}

extension PostsViewModel: UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection
        _: Int) -> Int {
        let fetchedposts = fetchSavedCoreData(with: Posts.self)
        postsArray = fetchedposts
        return postsArray.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                            for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        let post = postsArray
        let info = post[indexPath.item]
        cell.updateCell(with: info)

        return cell
    }
}

extension PostsViewModel: UICollectionViewDelegate {
    func collectionView(_: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let posts = fetchSavedCoreData(with: Posts.self)
        let postInfo = posts[indexPath.item]
        let authorArray = fetchSavedCoreData(with: Author.self)
        let author = getAuthorInfo(using: postInfo, with: authorArray)
        let comments = fetchSavedCoreData(with: Comment.self)
        let commentCount = getCommentsCount(
            using: postInfo, with: comments
        )

        delegate?.showPostDetails(post: (
            author: author, post: postInfo, commentsCount: commentCount
        ))
    }
}
