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
    func didLoadCoreDataError(error: Error)
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
        let postsPath = URLEndpoint.init(path: Paths.postsUrlPath)
        dispatchGroup.enter()
        savedData?.fetchAPIData(with: postsPath, completion: { result in
            switch result {
            case .failure(let error):
                self.delegate?.didLoadCoreDataError(error: error)
            case .success():
                do {
                    let authorPath = URLEndpoint.init(path: Paths.authorUrlPath)
                    dispatchGroup.enter()
                    self.savedData?.fetchAPIData(with: authorPath, completion: { result in
                        switch result {
                        case .failure(let error):
                            self.delegate?.didLoadCoreDataError(error: error)
                        case .success():
                            do {
                                dispatchGroup.enter()
                                let commentsPath = URLEndpoint.init(path: Paths.commentsUrlPath)
                                self.savedData?.fetchAPIData(with: commentsPath, completion: { result in
                                    switch result {
                                    case .failure(let error):
                                        self.delegate?.didLoadCoreDataError(error: error)
                                    case .success():
                                        dispatchGroup.leave()
                                    }
                                })
                            }
                            dispatchGroup.leave()
                        }
                    })
                }
                dispatchGroup.leave()
            }
        })

        dispatchGroup.notify(queue: .main) {
            self.delegate?.didLoadCoreData()
        }
    }

    
    
    private func entityIsEmpty<T: NSManagedObject>(entity: T.Type) -> Bool {
        let entityName = String(describing: entity)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            return try PersistenceService.context.count(for: fetchRequest) == 0
        } catch let error {
            self.delegate?.didLoadCoreDataError(error: error)
        }
        return false
    }

}
