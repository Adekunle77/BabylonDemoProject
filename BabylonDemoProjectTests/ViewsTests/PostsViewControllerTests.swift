//
//  PostsViewControllerTests.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 31/07/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import XCTest
import CoreData
@testable import BabylonDemoProject

class PostsViewControllerTests: XCTestCase {
    let mockPersistentContainer = MockPersistentContainer()
    let navigationController = MockNavigationController()
    var mainCoordinator: MainCoordinator?
    var storageManager: StorageManager!
    var postsVC: PostsViewController?
    let properties = TestProperties()
    let viewModel = PostsViewModel()

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

    class MockNavigationController: UINavigationController {
        var pushedViewContreoller: UIViewController?

        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            pushedViewContreoller = viewController
            super.pushViewController(viewController, animated: true)
        }
    }

    override func setUp() {
        mainCoordinator = MainCoordinator(navigationController: navigationController)

        storageManager = StorageManager(persistentContainer: mockPersistentContainer.mockPersistentContainer)
        viewModel.storageManager = storageManager
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        postsVC = storyboard.instantiateViewController(withIdentifier: "PostsViewController") as? PostsViewController

        _ = postsVC?.view
    }

    func testRefreshDataButtonCallsRefreshDataFunction() {
        let posts = Posts(userId: 1, identification: 1, body: "Test1", title: "TestOne")

        _ = storageManager.insert(posts)

        postsVC?.didTapRefreshButton(viewModel)

        let post = storageManager.fetchAllPosts()

        XCTAssertNotNil(viewModel.refreshData)
        XCTAssertEqual(numberOfItemsInPostsPersistanceStore(), post.count)

    }

    func testShowPostDetailsDidPushPostDetailVC() {
        let postDetailVC = PostDetailViewController()

        var tuple: PostTuple?
        tuple?.author.name = "Author"
        tuple?.commentsCount = "5"
        tuple?.post.title = "Title"
        guard let postTuple = tuple else { return }

        postsVC?.showPostDetails(post: postTuple)

        XCTAssertEqual(mainCoordinator?.count, 1)
        XCTAssertEqual(postDetailVC.postDetails?.commentsCount, tuple?.commentsCount)
    }

    func numberOfItemsInPostsPersistanceStore() -> Int? {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Posts")
        let result = try? mockPersistentContainer.mockPersistentContainer.viewContext.fetch(request)
        return result?.count
    }
}
