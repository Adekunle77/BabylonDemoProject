//
//  MainCoordinatorTests.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 02/08/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import XCTest
@testable import BabylonDemoProject

class MainCoordinatorTests: XCTestCase {

    var mainCooordinator: MainCoordinator?
    class MockNavigationController: UINavigationController {
        var pushedViewContreoller: UIViewController?

        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            pushedViewContreoller = viewController
            super.pushViewController(viewController, animated: true)
        }
    }

    override func setUp() {
        let navigationController = MockNavigationController()
        mainCooordinator = MainCoordinator(navigationController: navigationController)
    }

    func testDidFinishWithViewRemovesControllers() {
        let viewController = UIViewController()
        let navigationController = MockNavigationController(rootViewController: viewController)
        UIApplication.shared.keyWindow?.rootViewController = navigationController

        mainCooordinator?.pushPostVC()
        XCTAssertEqual(mainCooordinator?.count, 1)

        mainCooordinator?.popPostVC()
        XCTAssertEqual(mainCooordinator?.count, 1)
    }

    func testStartDidPushContentStateVC() {
        let contentStateVC = ContentStateViewController()

        mainCooordinator?.start()

        XCTAssertNotNil(contentStateVC.viewDidLoad)
    }

    func testDidPushPostVC() {
        mainCooordinator?.pushPostVC()

        XCTAssertEqual(mainCooordinator?.count, 1)
    }

    func testDidPushErrorVC() {
        let errorArray = [Error]()

        mainCooordinator?.pushErrorVC(with: errorArray)

        XCTAssertEqual(mainCooordinator?.count, 1)
    }

    func testDidPushLoadingVC() {
        mainCooordinator?.pushLoadingVC()

        XCTAssertEqual(mainCooordinator?.count, 1)
    }

    func testDidPushPostDetailVC() {
        var tuple: PostTuple?
        tuple?.author.name = "Author"
        tuple?.commentsCount = "5"
        tuple?.post.title = "Title"

        guard let postTuple = tuple else { return }
        mainCooordinator?.pushPostDetailVC(with: postTuple)

        XCTAssertEqual(mainCooordinator?.count, 1)
    }

}
