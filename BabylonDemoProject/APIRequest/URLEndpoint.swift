//
//  URLEndpoints.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

struct URLEndpoint {
    let path: Paths
}

enum Paths: String {
    case postsUrlPath = "/posts"
    case authorUrlPath = "/users"
    case commentsUrlPath = "/comments"
}

extension URLEndpoint {
    var url: URL? {
    var components = URLComponents()
        components.scheme = "https"
        components.host = "jsonplaceholder.typicode.com"
        components.path = path.rawValue
        return components.url
    }
}

extension URLEndpoint {
        
    func parse(_ data: Data) throws -> ModelType {
        let decoder = JSONDecoder()
        switch path {
        case .postsUrlPath:
            return try .posts(decoder.decode([PostsModel].self, from: data))
        case .authorUrlPath:
            return try .authors(decoder.decode([AuthorModel].self, from: data))
        case .commentsUrlPath:
            return try .comments(decoder.decode([CommentModel].self, from: data))
        }
    }

}
