//
//  LoadingViewControllerTests.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 07/08/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import XCTest
@testable import BabylonDemoProject

class LoadingViewControllerTests: XCTestCase {
    var loadingVC: LoadingViewController?
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
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        loadingVC = storyboard.instantiateViewController(
            withIdentifier: "LoadingViewController") as? LoadingViewController

        _ = loadingVC?.view
    }
}
