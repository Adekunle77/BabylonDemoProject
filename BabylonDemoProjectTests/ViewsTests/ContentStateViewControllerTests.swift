//
//  ContentStateViewControllerTests.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 07/08/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import XCTest
@testable import BabylonDemoProject

class ContentStateViewControllerTests: XCTestCase {

    var contentStateVC: ContentStateViewController?
    let contentStateViewModel = ContentStateViewModel()
    var mainCooordinator: MainCoordinator?
    class MockNavigationController: UINavigationController {
        var pushedViewContreoller: UIViewController?

        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            pushedViewContreoller = viewController
            super.pushViewController(viewController, animated: true)
        }
    }

    override func setUp() {
        let mockNavigationController = MockNavigationController()
        mainCooordinator = MainCoordinator(navigationController: mockNavigationController)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        contentStateVC = storyboard.instantiateViewController(
            withIdentifier: "ContentStateViewController") as? ContentStateViewController
        _ = contentStateVC?.view
    }

    func testDidUpdateWithData() {
        XCTAssertEqual(mainCooordinator?.count, 0)
        contentStateVC?.didUpdateWithData()

        XCTAssertEqual(mainCooordinator?.count, 1)
    }
}
