//
//  URLEndpoints.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

// This enum is created for the 3 different end points of the API url.
// Doing this helps when making the API request, parsing the retrieved
// the data amd for other functions.

enum ContentType: String {
    case posts
    case users
    case comments
}

extension ContentType {
    private var path: String {
        switch self {
        case .posts:
            return "/posts"
        case .users:
            return "/users"
        case .comments:
            return "/comments"
        }
    }

    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "jsonplaceholder.typicode.com"
        components.path = self.path
        return components.url
    }

    // init?
    func modelType(_ data: Data) throws -> ModelCollection {
        let decoder = JSONDecoder()
        switch self {
        case .posts:
            return try .posts(decoder.decode([PostsModel].self, from: data))
        case .users:
            return try .users(decoder.decode([UserModel].self, from: data))
        case .comments:
            return try .comments(decoder.decode([CommentModel].self, from: data))
        }
    }
}
