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
        do{
            let fetchObject = try PersistenceService.context.fetch(fetchRequest) as? [T]
            data = fetchObject ?? [T]()
        } catch let error {
            self.delegate?.modelDidUpdateWithError(error: error)
        }
        return data
    }
  
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
    
    func refreshData() {
        self.deleteSavedCoreData(with: Posts.self)
        self.deleteSavedCoreData(with: Author.self)
        self.deleteSavedCoreData(with: Comment.self)
        self.delegate?.modelDidUpdateWithData()
    }
    
    
    private func deleteSavedCoreData<T: NSManagedObject>(with objectType: T.Type) {
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do{
            try PersistenceService.context.execute(deleteRequest)
            PersistenceService.saveContext()
        } catch let error {
            self.delegate?.modelDidUpdateWithError(error: error)
        }
    }
    
}

extension PostsViewModel: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection
                            section: Int) -> Int {
        
        let fetchedposts = fetchSavedCoreData(with: Posts.self)
        self.postsArray = fetchedposts
        return self.postsArray.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        let post = self.postsArray
        let info = post[indexPath.item]
        cell.updateCell(with: info)

        return cell
    }
}

extension PostsViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let posts = fetchSavedCoreData(with: Posts.self)
        let postInfo = posts[indexPath.item]
        let authorArray = fetchSavedCoreData(with: Author.self)
        let author = self.getAuthorInfo(using: postInfo, with: authorArray)
        let comments = fetchSavedCoreData(with: Comment.self)
        let commentCount = self.getCommentsCount(
            using: postInfo, with: comments)
        
        self.delegate?.showPostDetails(post: (
            author: author, post: postInfo, commentsCount: commentCount))
        
    }
}
