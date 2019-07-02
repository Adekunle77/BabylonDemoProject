//
//  ContentStateViewControllerTests.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 15/06/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

@testable import BabylonDemoProject
import XCTest

class ContentStateViewControllerTests: XCTestCase {

    var contentStateVC: ContentStateViewController?
    private func setUpViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.contentStateVC =
            storyboard.instantiateViewController(withIdentifier: "ContentStateVC") as? ContentStateViewController
        self.contentStateVC?.loadView()
        self.contentStateVC?.viewDidLoad()
    }
    override func setUp() {
        super.setUp()
       self.setUpViewController()
    }

    override func tearDown() {
        self.contentStateVC = nil
        super.tearDown()
    }

//    func testIsStateNil() {
//        let state = contentStateVC.
//    }
}
