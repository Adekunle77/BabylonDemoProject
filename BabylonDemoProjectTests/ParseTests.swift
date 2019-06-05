//
//  ParseTests.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import XCTest
@testable import BabylonDemoProject

class ParseTests: XCTestCase {

    func testTitleData() {

        let tiles = [PostsModel(userId: 1, id: 1, body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto", title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")]
        
        if let path = Bundle.main.path(forResource: "Titles", ofType: "json"){
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                guard let jsonRequest = try Parse.titleData(data: data) else { return  }
                
                XCTAssertEqual(tiles, jsonRequest)
            } catch {
                print("failed")
            }
        }
    }
    
    func testAuthorData() {
        
        let geo = Geo(lat: "-37.3159", lng: "81.1496")
        
        let address = Address(street: "Kulas Light", suite: "Apt. 556", city: "Gwenborough", zipcode: "92998-3874", geo: geo)

        let company = Company(name: "Romaguera-Crona", catchPhrase: "Multi-layered client-server neural-net", bs: "harness real-time e-markets")
        
        let author = [AuthorModel(id: 1, name: "Bret", username: "Leanne Graham", email: "Sincere@april.biz", address: address, phone: "1-770-736-8031 x56442", website: "hildegard.org", company: company)]
        
        if let path = Bundle.main.path(forResource: "Authors", ofType: "json"){
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                guard let jsonRequest = try Parse.authorData(data: data) else { return  }
                
                XCTAssertEqual(author, jsonRequest)
            } catch {
                print("failed")
            }
        }
    }
    
    func testCommentsData() {
        
        let comments = [CommentModel(postId: 1, id: 1, name: "id labore ex et quam laborum", email: "Eliseo@gardner.biz", body: "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium")]
        
        if let path = Bundle.main.path(forResource: "Comments", ofType: "json"){
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                guard let jsonRequest = try Parse.commentsData(data: data) else { return  }
                
                XCTAssertEqual(comments, jsonRequest)
            } catch {
                print("failed")
            }
        }
    }
}

