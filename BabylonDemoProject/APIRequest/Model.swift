//
//  Model.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

// The struct conforms to Equatable for the purpose of testing. 
struct PostsModel: Codable, Equatable {
    let userId: Int
    let identification: Int
    let body: String
    let title: String
    enum CodingKeys: String, CodingKey {
        case userId, body, title
        case identification = "id"
    }
}

struct User: Codable, Equatable {
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

struct Address: Codable, Equatable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geocode: Geo
    enum CodingKeys: String, CodingKey, Equatable {
        case street, suite, city, zipcode
        case geocode = "geo"
    }
}

struct Geo: Codable, Equatable {
    let latitude: String
    let longitude: String
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}

struct Company: Codable, Equatable {
    let name: String
    let catchPhrase: String
    let business: String
    enum CodingKeys: String, CodingKey {
        case name, catchPhrase
        case business = "bs"
    }
}

struct Comment: Codable, Equatable {
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
