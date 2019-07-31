//
//  LoadManager.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 12/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import CoreData
import Foundation

protocol CoreDataLoadManagerDelegate: class {
    func didLoadCoreData()
    func didLoadCoreDataError(error: [Error])
}

class LoadManager {
    
    var dataSource = APIRequest()
    var networkManager: Network
    weak var delegate: CoreDataLoadManagerDelegate?

    init(networkManager: Network) {
        self.networkManager = networkManager
    }

    func fetchData() {
        let dispatchGroup = DispatchGroup()
        var errorsArray = [Error]()
        let postsPath = URLEndpoint(path: Paths.postsUrlPath)
        dispatchGroup.enter()
        networkManager.fetchAPIData(with: postsPath, completion: { result in
            switch result {
            case let .failure(error):
                errorsArray.append(error)
            case .success: break
            }
            dispatchGroup.leave()
        })

        let authorPath = URLEndpoint(path: Paths.authorUrlPath)
        dispatchGroup.enter()
       networkManager.fetchAPIData(with: authorPath, completion: { result in
            switch result {
            case let .failure(error):
                errorsArray.append(error)
            case .success: break
            }
            dispatchGroup.leave()
        })

        let commentsPath = URLEndpoint(path: Paths.commentsUrlPath)
        dispatchGroup.enter()
        networkManager.fetchAPIData(with: commentsPath, completion: { result in
            switch result {
            case let .failure(error):
                errorsArray.append(error)
            case .success: break
            }
            dispatchGroup.leave()
        })

        dispatchGroup.notify(queue: .main) {
            if errorsArray.count > 0 {
                self.delegate?.didLoadCoreDataError(error: errorsArray)               
            } else {
                self.delegate?.didLoadCoreData()
            }
        }
    }
}
