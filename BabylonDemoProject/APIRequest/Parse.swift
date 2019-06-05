//
//  Parse.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

final class Parse {
    
    static func titleData(data: Data) throws -> [PostsModel]? {
        let jsonDecoder = JSONDecoder()
        guard let parsedJson = try? jsonDecoder.decode([PostsModel].self, from: data) else {
            let parsedError = DataSourceError.noData.self
            throw parsedError
        }
        return parsedJson
    }
    
    static func authorData(data: Data) throws -> [AuthorModel]? {
        let jsonDecoder = JSONDecoder()
        guard let parsedJson = try? jsonDecoder.decode([AuthorModel].self, from: data) else {
            let parsedError = DataSourceError.noData.self
            throw parsedError
        }
        return parsedJson
    }
    
    static func commentsData(data: Data) throws -> [CommentModel]? {
        let jsonDecoder = JSONDecoder()
        guard let parsedJson = try? jsonDecoder.decode([CommentModel].self, from: data) else {
            let parsedError = DataSourceError.noData.self
            throw parsedError
        }
        return parsedJson
    }
    
}
