//
//  Parse.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

final class Parse {
    
    static func titleData(data: Data) throws -> [Titles]? {
        let jsonDecoder = JSONDecoder()
        guard let parsedJson = try? jsonDecoder.decode([Titles].self, from: data) else {
            let parsedError = DataSourceError.noData.self
            throw parsedError
        }
        return parsedJson
    }
    
    static func authorData(data: Data) throws -> [Authors]? {
        let jsonDecoder = JSONDecoder()
        guard let parsedJson = try? jsonDecoder.decode([Authors].self, from: data) else {
            let parsedError = DataSourceError.noData.self
            throw parsedError
        }
        return parsedJson
    }
    
    static func commentsData(data: Data) throws -> [Comments]? {
        let jsonDecoder = JSONDecoder()
        guard let parsedJson = try? jsonDecoder.decode([Comments].self, from: data) else {
            let parsedError = DataSourceError.noData.self
            throw parsedError
        }
        return parsedJson
    }
    
}
