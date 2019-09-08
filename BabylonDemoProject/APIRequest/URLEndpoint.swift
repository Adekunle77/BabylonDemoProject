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

enum URLEndpoint: String {
    case posts
    case users
    case comments

    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "jsonplaceholder.typicode.com"
        components.path = "/\(rawValue)"
        return components.url
    }

    func parse(_ data: Data) throws -> ModelType {
        let decoder = JSONDecoder()
        switch self {
        case .posts:
            return try .posts(decoder.decode([Posts].self, from: data))
        case .users:
            return try .users(decoder.decode([User].self, from: data))
        case .comments:
            return try .comments(decoder.decode([Comment].self, from: data))
        }
    }
}
