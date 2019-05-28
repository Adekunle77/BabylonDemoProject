//
//  MockAPI.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 13/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
@testable import BabylonDemoProject

class MockAPI: API {
    
    var isReturningError = false
    
    func fetchJSONdata(endPoint: URLEndpoint, completion: @escaping CompletionHandler) {
        
        if isReturningError {
            completion(.failure(.noData))
        } else {
            if endPoint.path == .authorUrlPath {
                let geo = Geo(lat: "-37.3159", lng: "81.1496")
                let address = Address(street: "Kulas Light", suite: "Apt. 556", city: "Gwenborough", zipcode: "92998-3874", geo: geo)
                let company = Company(name: "Romaguera-Crona", catchPhrase: "Multi-layered client-server neural-net", bs: "harness real-time e-markets")
                let author = [Authors(id: 1, name: "Bret", username: "Leanne Graham", email: "Sincere@april.biz", address: address, phone: "1-770-736-8031 x56442", website: "hildegard.org", company: company)]
                
                completion(.success(.authors(author)))
            }
            if endPoint.path == .commentsUrlPath {
                let comments = [Comments(postId: 1, id: 1, name: "id labore ex et quam laborum", email: "Eliseo@gardner.biz", body: "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium")]
                
                completion(.success(.comments(comments)))
            }
            if endPoint.path == .postsUrlPath {
                let tiles = [Titles(userId: 1, id: 1, body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto", title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")]
                
                completion(.success(.titles(tiles)))
            }
        }
    }
    
    
}
