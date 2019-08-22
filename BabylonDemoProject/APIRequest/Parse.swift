//
//  Parse.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 15/08/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

class Parse {

    func parseObject(with data: Data, from pathEndpoint: URLEndpoint) throws -> ModelType {
        let decoder = JSONDecoder()
        switch pathEndpoint.path {
        case .postsUrlPath:
            return try .posts(decoder.decode([PostsModel].self, from: data))
        case .authorUrlPath:
            return try .authors(decoder.decode([AuthorModel].self, from: data))
        case .commentsUrlPath:
            return try .comments(decoder.decode([CommentModel].self, from: data))
        }
    }
}
