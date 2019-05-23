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
    
    var post = [Posts]()
    let saveData = CoreDataLoadManager()
    weak var delegate: ContentStateViewModelDelegate?
    
    init() {
        creatObservers()
       // saveData.fetchTitleData()
        //getSavedPost()
    }
    
    private func creatObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(ContentStateViewModel.getSavedPost), name: didLoadPostsNotificationKey, object: nil)
        // Notification for error
        NotificationCenter.default.addObserver(self, selector: #selector(ContentStateViewModel.showSpinningWheel(notification:)), name: didLoadErrorNotificationKey, object: nil)
    }

    @objc func getSavedPost() {
        if saveData.posts.count > 0 {
            self.saveData.posts.forEach({post.append($0)})
            self.delegate?.didUpdateWithData()
        } else {
            saveData.fetchTitleData()
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
    
}
