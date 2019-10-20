//
//  MainCoordinator.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 29/07/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import UIKit

protocol ContentCoordinator: Coordinator {
    func showPosts()
    func showPostDetail(_ post: PostTuple)
    func showErrors(_ :[Error])
    func showLoading()
}

// The Coordinator Pattern is used avoid views being coupled togethier.
final class MainCoordinator: NSObject, ContentCoordinator {
    private var childCoordinator = [UIViewController]()
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        self.showDefaultContentState()
    }

    private func showDefaultContentState() {
        let contentStateVC = ContentStateViewController.instantiate()
        contentStateVC.coordinator = self
        childCoordinator.append(contentStateVC)
        navigationController.pushViewController(contentStateVC, animated: false)
    }

    func showPosts() {
        let postVC = PostsViewController.instantiate()
        postVC.coordinator = self
        childCoordinator.append(postVC)
        navigationController.pushViewController(postVC, animated: true)
    }

    func popPostVC() {
        if let popVC = navigationController.popViewController(animated: true) {
            childDidFinish(popVC)
        }
    }

    func showErrors(_ errors: [Error]) {
        let errorVC = ErrorViewController.instantiate()
        errorVC.errors = errors
        errorVC.coordinator = self
        childCoordinator.append(errorVC)
        navigationController.pushViewController(errorVC, animated: false)
    }

    func showLoading() {
        let loadingVC = LoadingViewController.instantiate()
        loadingVC.coordinator = self
        childCoordinator.append(loadingVC)
        navigationController.pushViewController(loadingVC, animated: false)
    }

    func showPostDetail(_ post: PostTuple) {
        let postDetailVC = PostDetailViewController.instantiate()
        postDetailVC.coordinator = self
        postDetailVC.postDetails = post
        navigationController.pushViewController(postDetailVC, animated: true)
    }

    // This function appends and removes view controllers.
    func childDidFinish(_ child: UIViewController) {
    // This checks if the first element in the array is a view controller that
    // is a of type Coordinator. If true then it removes it.
        if let index = childCoordinator.firstIndex(where: { (coordinator) -> Bool in coordinator == child }) {
            childCoordinator.remove(at: index)
        }
    }
}

#if DEBUG
extension MainCoordinator {
    var count: Int {
        return childCoordinator.count
    }
}
#endif
