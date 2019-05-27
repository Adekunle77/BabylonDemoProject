//
//  PersistenceService.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 11/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import CoreData

protocol SaveDataDelegate: class {
    func CoreDataSavedAuthor()
    func dataDidSaveTitle()
    func dataDidSaveComment()
    func dataSavingError(error: Error)
}


class CoreDataSaveManager {
    
    let dataSource: API
    weak var delegate: SaveDataDelegate?
    init(dataSource: API) {
        self.dataSource = dataSource
    }
    
    func fetchAPIData(with path: URLEndpoint) {

        dataSource.fetchJSONdata(endPoint: path, completion: {[weak self] result in
            switch result {
            case .failure(let error):
                self?.delegate?.dataSavingError(error: error)
            case .success(let data):
                switch path.path {
                case .authorUrlPath:
                    self?.checkDataIsAuthor(data: data)
                case .commentsUrlPath:
                    self?.checkDataIsComment(data: data)
                case .titleUrlPath:
                    self?.checkDataIsTitle(data: data)
                }
            }
        })
    }
    
    func checkDataIsAuthor(data: (ModelType)) {
            switch data {
            case .authors(let authors):
                saveAuthorData(with: authors)
                self.delegate?.CoreDataSavedAuthor()
            default:
                break
            }
    }
    
    func checkDataIsComment(data: (ModelType)) {
            switch data {
            case .comments(let comments):
                saveCommentData(with: comments)
                self.delegate?.dataDidSaveComment()
            default:
                break
            }
    }
    
    func checkDataIsTitle(data: (ModelType)) {
            switch data {
            case .titles(let title):
                saveTitleData(with: title)
                self.delegate?.dataDidSaveTitle()
            default:
                break
            }
    }

    func saveTitleData(with dataArray: [Titles]) {
        for item in dataArray {
            let title = Posts(context: PersistenceService.context)
            title.title = item.title
            title.body = item.body
            title.id = Int16(item.id)
            title.userID = Int16(item.userId)
            PersistenceService.saveContext()
        }
        
    }
    
    private func saveAuthorData(with dataArray: [Authors]) {
        for item in dataArray {
            let author = Author(context: PersistenceService.context)
            author.name = item.name
            author.authorID = Int16(item.id)
            PersistenceService.saveContext()
        }
    }
    
    private func saveCommentData(with dataArray: [Comments]) {
        for item in dataArray {
            let comment = Comment(context: PersistenceService.context)
            comment.comments = item.body
            comment.postId = Int16(item.postId)
            comment.id = Int16(item.id)
            PersistenceService.saveContext()
        }
    }
}
    
    

