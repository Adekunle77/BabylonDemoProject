//
//  LoadingViewModel.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//


import Foundation
import CoreData
import UIKit

protocol ViewModelDelegate: class {
    func modelDidUpdateData()
    func modelDidUpdateWithError(error: Error)
    func showPostDetails(post: PostTuple)
}

typealias PostTuple = (author: Author, post: Posts, commentsCount: String)

class PostsViewModel: NSObject {
    

   // private var posts = [Posts]()
    weak var delegate: ViewModelDelegate?
    let reuseIdentifier = "Cell"
    
//    override init() {
//        super .init()
//
//        //coreDataSavedPosts()
//    }
    
    
    private func fetchSavedCoreData<T: NSManagedObject>(with objectType: T.Type) -> [T] {
        var data = [T]()
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do{
            let fetchObject = try PersistenceService.context.fetch(fetchRequest) as? [T]
            data = fetchObject ?? [T]()
        } catch let error {
            print("error")
            self.delegate?.modelDidUpdateWithError(error: error)
        }
        return data
    }
    
//    func coreDataSavedPosts() {
//        let fetchRequest: NSFetchRequest<Posts> = Posts.fetchRequest()
//        do {
//            let title = try PersistenceService.context.fetch(fetchRequest)
//            self.delegate?.modelDidUpdateData()
//        } catch let error {
//          self.delegate?.modelDidUpdateWithError(error: error)
//            print(error)
//        }
//    }


//    private func loadPosts() -> [Posts] {
//        var titleArray = [Posts]()
//        loadData.posts.forEach({titleArray.append($0)})
//        return titleArray
//    }
//
//    private func loadAuthorInfo() -> [Author] {
//        var authorArray = [Author]()
//        loadData.author.forEach({authorArray.append($0)})
//        return authorArray
//    }
//
//    private func loadComments() -> [Comment] {
//        var commentsArray = [Comment]()
//        loadData.comment.forEach({commentsArray.append($0)})
//        return commentsArray
//    }
//
    private func getCommentsCount(using post: Posts, with array: [Comment]) -> String {
        let userID = post.id
        let comments = array.all(where: {$0.postId == userID})

        return String(comments.count)
    }

    private func getAuthorInfo(using title: Posts, with array: [Author]) -> Author {
        let userID = title.userID
        var author = Author(context: PersistenceService.context)

        if let id = array.first(where: {$0.authorID == userID}) {
            author = id
        }
        return author
    }
    
}

extension PostsViewModel: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchSavedCoreData(with: Posts.self).count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell

        let data = fetchSavedCoreData(with: Posts.self)
        let info = data[indexPath.item]
        cell.updateCell(with: info)

        return cell
    }
}

extension PostsViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let posts = fetchSavedCoreData(with: Posts.self)
        let postInfo = posts[indexPath.item]
        let authorArray = fetchSavedCoreData(with: Author.self)
        let author = self.getAuthorInfo(using: postInfo, with: authorArray)
        let comments = fetchSavedCoreData(with: Comment.self)
        let commentCount = self.getCommentsCount(using: postInfo, with: comments)
        self.delegate?.showPostDetails(post: (author: author, post: postInfo, commentsCount: commentCount))
    }
}
