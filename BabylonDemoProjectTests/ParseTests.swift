//
//  ParseTests.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

@testable import BabylonDemoProject
import XCTest

class ParseTests: XCTestCase {
    let properties = TestProperties()
    func testTitleData() {
        let modelType = ModelType.self
        let posts = [properties.postItem()]
        if let path = Bundle.main.path(forResource: "Titles", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let parse = URLEndpoint(path: .postsUrlPath)
                guard let jsonRequest = try? parse.parse(data) else { return }
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

        if let path = Bundle.main.path(forResource: "Authors", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let parse = URLEndpoint(path: .authorUrlPath)
                guard let jsonRequest = try? parse.parse(data) else { return }
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
        if let path = Bundle.main.path(forResource: "Comments", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let parse = URLEndpoint(path: .authorUrlPath)
                guard let jsonRequest = try? parse.parse(data) else { return }
                let parseData = modelType.comments(comments)
                XCTAssertEqual(parseData, jsonRequest)
            } catch {
                print("failed")
            }
        }
    }
}
