//

//  ContentStateViewModel.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 21/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit
import CoreData

protocol ContentStateViewModelDelegate: class {
    func didUpdateWithData()
    func didUpdateWithError(error: [Error])
    func dataLoading()
}

class ContentStateViewModel {
    var postsArray = [Posts]()
    var loadManager: LoadManager?
    private let storageManager: StorageManager?
    weak var delegate: ContentStateViewModelDelegate?

    init() {
        let dataSource = APIRequest()
        let networkManager = NetworkManager(dataSource: dataSource)
        loadManager = LoadManager(networkManager: networkManager)
        storageManager = StorageManager(persistentContainer: PersistenceService.persistentContainer)
        loadManager?.delegate = self
    }
    
    func numberOfSavedPosts() -> Int? {
        let posts = storageManager?.fetchAllPosts()
        return posts?.count
    }
    
    func loadData() {
        if numberOfSavedPosts() == 0 {
            loadManager?.fetchData()
            delegate?.dataLoading()
        } else {
            delegate?.didUpdateWithData()
        }
    }    
}

extension ContentStateViewModel: CoreDataLoadManagerDelegate {
    func didLoadCoreData() {
        delegate?.didUpdateWithData()
    }

    func didLoadCoreDataError(error: [Error]) {
        delegate?.didUpdateWithError(error: error)
    }
}
