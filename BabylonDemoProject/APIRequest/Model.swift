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
    let identification: Int
    let body: String
    let title: String
    enum CodingKeys: String, CodingKey {
        case userId, body, title
        case identification = "id"
    }
}

struct UserModel: Codable {
    let identification: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    enum CodingKeys: String, CodingKey {
        case name, username, email, address, phone, website, company
        case identification = "id"
    }
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geocode: Geo
    enum CodingKeys: String, CodingKey {
        case street, suite, city, zipcode
        case geocode = "geo"
    }
}

struct Geo: Codable {
    let latitude: String
    let longitude: String
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}

struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bachelorScience: String
    enum CodingKeys: String, CodingKey {
        case name, catchPhrase
        case bachelorScience = "bs"
    }
}

struct CommentModel: Codable {
    let postId: Int
    let identification: Int
    let name: String
    let email: String
    let body: String
    enum CodingKeys: String, CodingKey {
        case postId, name, email, body
        case identification = "id"
    }
}

// These structs have been to confirm to Equatable for the purpose of testing.

extension PostsModel: Equatable {
    static func == (lhs: PostsModel, rhs: PostsModel) -> Bool {
        return lhs.identification == rhs.identification &&
            lhs.userId == rhs.userId &&
            lhs.body == rhs.body &&
            lhs.title == rhs.title
    }
}

extension UserModel: Equatable {
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.identification == rhs.identification &&
            lhs.name == rhs.name &&
            lhs.username == rhs.username &&
            lhs.email == rhs.email &&
            lhs.phone == rhs.phone &&
            lhs.website == rhs.website
    }
}

extension CommentModel: Equatable {
    static func == (lhs: CommentModel, rhs: CommentModel) -> Bool {
        return lhs.postId == rhs.postId &&
            lhs.identification == rhs.identification &&
            lhs.name == rhs.name &&
            lhs.email == rhs.email &&
            lhs.body == rhs.body
    }
}
