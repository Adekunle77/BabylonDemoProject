//
//  ContentStateViewModel.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 21/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//
import Foundation
import CoreData
import UIKit


protocol ContentStateViewModelDelegate: class {
    func didUpdateWithData()
    func didUpdateWithError(error: Error)
}

class ContentStateViewModel {
    
    var postsArray = [Posts]()
    let saveData = CoreDataLoadManager()
    weak var delegate: ContentStateViewModelDelegate?
    init() {
        if self.postsArray.isEmpty == true {
            self.getPosts()
        }
    }
    
    
    @objc func getPosts() {
        let entityName = String(describing: Posts.self)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(
            entityName: entityName)
        do {
            let fetchObject = try PersistenceService.context.fetch(fetchRequest) as? [Posts]
            guard fetchObject != nil else { return }
            self.postsArray = fetchObject ?? [Posts]()
            if fetchObject?.count ?? 0 > 0 {
                self.delegate?.didUpdateWithData()
                self.postsArray.removeAll()
            } else {
                self.saveData.fetchPostData()
            }
        } catch let error {
            self.delegate?.didUpdateWithError(error: error)
        }
    }
    
    @objc func didReceiveError(notification: NSNotification) {
        if let error = notification.userInfo?["error"] as? Error {
            self.delegate?.didUpdateWithError(error: error)
        }
    }
}
