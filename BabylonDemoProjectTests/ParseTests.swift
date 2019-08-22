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
    var coreDataManager: StorageManager!
    let properties = TestProperties()

    func testTitleData() {
        let modelType = ModelType.self
        let posts = [properties.postItem()]
        let item = Parse()
        if let path = Bundle.main.path(forResource: "Titles", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let endPoint = URLEndpoint(path: .postsUrlPath)
                guard let jsonRequest = try? item.parseObject(with: data, from: endPoint)  else { return }
                let parseData = modelType.posts(posts)
                XCTAssertEqual(parseData, jsonRequest)
            } catch {
                print("failed")
            }
        }
    }

    func testAuthorData() {
        let modelType = ModelType.self
        let author = [properties.authorItem()]
        let item = Parse()
        if let path = Bundle.main.path(forResource: "Authors", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let endPoint = URLEndpoint(path: .authorUrlPath)
                guard let jsonRequest = try?  item.parseObject(with: data, from: endPoint) else { return }
                let parseData = modelType.authors(author)
                XCTAssertEqual(parseData, jsonRequest)
            } catch {
                print("failed")
            }
        }
    }

    func testCommentsData() {
        let modelType = ModelType.self
        let comments = [properties.commentItem()]
        let item = Parse()
        if let path = Bundle.main.path(forResource: "Comments", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let endPoint = URLEndpoint(path: .commentsUrlPath)
                guard let jsonRequest = try? item.parseObject(with: data, from: endPoint) else { return }
                let parseData = modelType.comments(comments)
                XCTAssertEqual(parseData, jsonRequest)
            } catch {
                print("failed")
            }
        }
    }
}
