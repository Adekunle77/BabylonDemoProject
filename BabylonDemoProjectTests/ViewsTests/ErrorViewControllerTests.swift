//
//  ErrorViewControllerTests.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 06/08/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import XCTest
@testable import BabylonDemoProject

class ErrorViewControllerTests: XCTestCase {

    var errorVC: ErrorViewController?
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
        errorVC = storyboard.instantiateViewController(withIdentifier: "ErrorViewController") as? ErrorViewController

        _ = errorVC?.view
    }
}
