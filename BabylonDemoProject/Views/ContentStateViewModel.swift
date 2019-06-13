//
import CoreData
//  ContentStateViewModel.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 21/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//
import Foundation
import UIKit

protocol ContentStateViewModelDelegate: class {
    func didUpdateWithData()
    func didUpdateWithError(error: [Error])
}

class ContentStateViewModel {
    var postsArray = [Posts]()
    let saveData = CoreDataLoadManager()
    weak var delegate: ContentStateViewModelDelegate?

    init() {
        // self.getPosts()
        saveData.delegate = self
    }

    func getPosts() {
        let entityName = String(describing: Posts.self)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(
            entityName: entityName
        )
        do {
            let fetchObject = try PersistenceService.context.fetch(fetchRequest) as? [Posts]
            guard fetchObject != nil else { return }
            if let fetchedPost = fetchObject {
                postsArray = fetchedPost
            }
            if postsArray.count == 0 {
                saveData.fetchData()
            } else {
                delegate?.didUpdateWithData()
            }
        } catch {
            var errorsArray = [Error]()
            errorsArray.append(error)
            delegate?.didUpdateWithError(error: errorsArray)
        }
    }
    
    
    
    func stringLocalizedError(error: [Error]) -> String{
        var errorMessage = String()
        for message in error {
            errorMessage += "\(message.localizedDescription) \n"
        }
        return errorMessage
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
