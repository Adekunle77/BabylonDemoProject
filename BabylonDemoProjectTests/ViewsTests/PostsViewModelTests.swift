//
//  PostsViewModelTests.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 19/07/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import XCTest
@testable import BabylonDemoProject

class PostsViewModelTests: XCTestCase {
    let testProperties = TestProperties()

    class MockViewModelDelegate: ViewModelDelegate {
        var timesDidLoadDataCalled = 0
        var timesErrorCalled = 0
        var showPostDetails = 0

        func modelDidUpdateWithData() {
            timesDidLoadDataCalled += 1
        }

        func modelDidUpdateWithError(error: Error) {
            timesErrorCalled += 1
        }

        func showPostDetails(post: PostTuple) {
            showPostDetails += 1
        }
    }

    func testGetCommentsCount() {
        let postViewModel = PostsViewModel()
        let post = testProperties.postItem()
        let comments = testProperties.commentItem()
        var storageManager: StorageManager!
        let mockPersistentContainer = MockPersistentContainer()
        storageManager = StorageManager(persistentContainer: mockPersistentContainer.mockPersistentContainer)
        _ = storageManager.insert(post)
        _ = storageManager.insert(comments)
        let fetchPosts = storageManager.fetchAllPosts()
        let fetchComments = storageManager.fetchAllComments()

        let commentsCount = postViewModel.testGetCommentsCount(using: fetchPosts[0], with: fetchComments)

        XCTAssertEqual(commentsCount, "1")
    }

    func testGetAuthorInfo() {
        let postViewModel = PostsViewModel()
        let posts = testProperties.postItem()
        let authors = testProperties.authorItem()
        var storageManager: StorageManager!
        let mockPersistentContainer = MockPersistentContainer()
        storageManager = StorageManager(persistentContainer: mockPersistentContainer.mockPersistentContainer)
        _ = storageManager.insert(posts)
        _ = storageManager.insert(authors)
        let fetchPosts = storageManager.fetchAllPosts()
        let fetchAuthors = storageManager.fetchAllAuthors()

        let fetchAuthor = postViewModel.testGetAuthorInfo(using: fetchPosts[0], with: fetchAuthors)

        XCTAssertEqual(fetchAuthors[0], fetchAuthor)

    }

    func testRefreshDataReturnsData() {
        let mockDelegate = MockViewModelDelegate()
        let postViewModel = PostsViewModel()
        postViewModel.delegate = mockDelegate

        let posts = testProperties.postItem()
        let authors = testProperties.authorItem()
        let comments = testProperties.commentItem()
        var storageManager: StorageManager!
        let mockPersistentContainer = MockPersistentContainer()
        storageManager = StorageManager(persistentContainer: mockPersistentContainer.mockPersistentContainer)
        _ = storageManager.insert(posts)
        _ = storageManager.insert(authors)
        _ = storageManager.insert(comments)

        postViewModel.refreshData()

        XCTAssertEqual(mockDelegate.timesDidLoadDataCalled, 1)
        XCTAssertEqual(mockDelegate.timesErrorCalled, 0)
    }

    func testRefreshDataReturnsError() {
        let mockDelegate = MockViewModelDelegate()
        let postViewModel = PostsViewModel()
        postViewModel.delegate = mockDelegate

        let mockAPI = MockAPI(isReturningError: true)
        let path = URLEndpoint.posts
        mockAPI.fetchJSONData(endpoint: path, completion: {result in
            switch result {
            case .failure(let error):
                mockDelegate.modelDidUpdateWithError(error: error)
            case .success:
                mockDelegate.modelDidUpdateWithData()
            }
        })
        XCTAssertEqual(mockDelegate.timesDidLoadDataCalled, 0)
        XCTAssertEqual(mockDelegate.timesErrorCalled, 1)
    }
}
