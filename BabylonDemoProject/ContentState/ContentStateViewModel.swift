//

//  ContentStateViewModel.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 21/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit
import CoreData

// This viewModel checks if there is data is available via Core Data. If there is
// no data makes a API request to get data.


protocol ContentStateViewModelDelegate: class {
    func didUpdateWithData()
    func didUpdateWithError(error: [Error])
    func dataIsLoading()
}

class ContentStateViewModel {
    private var loadManager: LoadManager?
    private let storageManager: StorageManager?
    weak var delegate: ContentStateViewModelDelegate?

    init() {
        let dataSource = APIRequest()
        let networkManager = NetworkManager(dataSource: dataSource)
        loadManager = LoadManager(networkManager: networkManager)
        storageManager = StorageManager(persistentContainer: PersistenceService.persistentContainer)
        loadManager?.delegate = self
    }

    private func numberOfSavedPosts() -> Int? {
        let posts = storageManager?.fetchAllPosts()
        return posts?.count
    }

    private func isEmpty() -> Bool {
        return numberOfSavedPosts() == 0
    }

    func loadData() {
        if isEmpty() {
            loadManager?.fetchData()
            delegate?.dataIsLoading()
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
