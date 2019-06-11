//
//  LoadData.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 12/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataLoadManagerDelegate {
    func didLoadCoreData()
    func didLoadCoreDataError(error: [Error])
}

class CoreDataLoadManager {

    var dataSource = APIRequest()
    private var savedData: CoreDataSaveManager?
    var delegate: CoreDataLoadManagerDelegate?
  
    
    init() {
        self.savedData = CoreDataSaveManager(dataSource: dataSource)
    }
    
    
    func fetchData() {
        let dispatchGroup = DispatchGroup()
        var errorsArray = [Error]()
        let postsPath = URLEndpoint.init(path: Paths.postsUrlPath)
        dispatchGroup.enter()
        savedData?.fetchAPIData(with: postsPath, completion: { result in
            switch result {
            case .failure(let error):
                errorsArray.append(error)
            case .success(): break
            }
            dispatchGroup.leave()
        })
        
        let authorPath = URLEndpoint.init(path: Paths.authorUrlPath)
        dispatchGroup.enter()
        savedData?.fetchAPIData(with: authorPath, completion: { result in
            switch result {
            case .failure(let error):
                errorsArray.append(error)
            case .success(): break
            }
            dispatchGroup.leave()
        })
        
        let commentsPath = URLEndpoint.init(path: Paths.authorUrlPath)
        dispatchGroup.enter()
        savedData?.fetchAPIData(with: commentsPath, completion: { result in
            switch result {
            case .failure(let error):
                errorsArray.append(error)
            case .success(): break
            }
           dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: .main) {
            print(errorsArray.count)
            if errorsArray.count > 0 {
                self.delegate?.didLoadCoreDataError(error: errorsArray)
            } else {
                self.delegate?.didLoadCoreData()
            }
        }
    }
}
