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
        //self.getPosts()
        self.saveData.delegate = self
    }
    
    func getPosts() {
        let entityName = String(describing: Posts.self)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(
            entityName: entityName)
        do {
            let fetchObject = try PersistenceService.context.fetch(fetchRequest) as? [Posts]
            guard fetchObject != nil else { return }
            if let fetchedPost = fetchObject {
                self.postsArray = fetchedPost
                print(postsArray.count)
            }
            if self.postsArray.count == 0 {    
                self.saveData.fetchData()
            } else {
               self.delegate?.didUpdateWithData()
            }
        } catch {
            self.delegate?.didUpdateWithError(error: error)
        }
    }
    
}

extension ContentStateViewModel: CoreDataLoadManagerDelegate {
    func didLoadCoreData() {
        self.delegate?.didUpdateWithData()
    }
    
    func didLoadCoreDataError(error: Error) {
        self.delegate?.didUpdateWithError(error: error)
    }
    
    
}
