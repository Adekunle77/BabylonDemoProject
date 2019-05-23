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
    case titleUrlPath = "/posts"
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

