//
//  Model.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

struct PostsModel: Codable {
    let userId: Int
    let id: Int
    let body: String
    let title: String
}

struct AuthorModel: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

struct Geo: Codable {
    let lat: String
    let lng: String
}

struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}

struct CommentModel: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}

extension PostsModel: Equatable {
    static func ==(lhs: PostsModel, rhs: PostsModel) -> Bool {
    
        return lhs.id == rhs.id &&
            lhs.userId == rhs.userId &&
            lhs.body == rhs.body &&
            lhs.title == rhs.title
    }
}


extension AuthorModel: Equatable {
    static func ==(lhs: AuthorModel, rhs: AuthorModel) -> Bool {
        
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.username == rhs.username &&
            lhs.email == rhs.email &&
            lhs.phone == rhs.phone &&
            lhs.website == rhs.website
    }
}

extension CommentModel: Equatable {
    static func ==(lhs: CommentModel, rhs: CommentModel) -> Bool {
        
        return lhs.postId == rhs.postId &&
            lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.email == rhs.email &&
            lhs.body == rhs.body
    }
}
