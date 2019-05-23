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
    
    let saveData = CoreDataLoadManager()
    weak var delegate: ContentStateViewModelDelegate?
    
    init() {
        creatObservers()
        getSavedPost()
    }
    
    private func creatObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ContentStateViewModel.getSavedPost),
                                               name: didLoadPostsNotificationKey,
                                               object: nil)
        // Notification for error
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ContentStateViewModel.showSpinningWheel(notification:)), name: didLoadErrorNotificationKey, object: nil)
    }
    

    @objc func getSavedPost() {
        if saveData.posts.count > 0 {
            self.delegate?.didUpdateWithData()
        }
    }
    
    
    @objc func showSpinningWheel(notification: NSNotification) {
        if let error = notification.userInfo?["error"] as? Error {
            self.delegate?.didUpdateWithError(error: error)
        }
    }
    
    func updateContenStateView() {
        self.delegate?.didUpdateWithData()
    }
    
    func entityIsEmpty<T>(entity: T.Type) -> Bool {
        var data = [T]()
        let entityName = String(describing: entity)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do{
            let fetchObject = try PersistenceService.context.fetch(fetchRequest) as? [T]
            data = fetchObject ?? [T]()
            if data.isEmpty {
                return true
            }
        } catch let error {
            self.delegate?.didUpdateWithError(error: error)
        }

        return false
    }
    
    
    func refreshData() {
        print(refreshData)
        //saveData.refreshData()
    }
    
}
