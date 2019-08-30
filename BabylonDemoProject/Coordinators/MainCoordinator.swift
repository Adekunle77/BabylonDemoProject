//
//  MainCoordinator.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 29/07/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import UIKit

// The Coordinator Pattern is used avoid views being coupled togethier.
final class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    // childcoordinator an UIViewController array to add and remove UIViewController
    private var childcoordinator = [UIViewController]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.delegate = self
        let constateVC = ContentStateViewController.instantiate()
        constateVC.coordinator = self
        childcoordinator.append(constateVC)
        navigationController.pushViewController(constateVC, animated: false)
    }

    func pushPostVC() {
        let postVC = PostsViewController.instantiate()
        postVC.coordinator = self
        childcoordinator.append(postVC)
        navigationController.pushViewController(postVC, animated: true)
    }

    func popPostVC() {
        if let popVC = navigationController.popViewController(animated: true) {
            childDidFinish(popVC)
        }
    }

    func pushErrorVC(with error: [Error]) {
        let errorVC = ErrorViewController.instantiate()
        errorVC.errors = error
        errorVC.coordinator = self
        childcoordinator.append(errorVC)
        navigationController.pushViewController(errorVC, animated: false)
    }

    func pushLoadingVC() {
        let loadingVC = LoadingViewController.instantiate()
        loadingVC.coordinator = self
        childcoordinator.append(loadingVC)
        navigationController.pushViewController(loadingVC, animated: false)
    }

    func pushPostDetailVC(with post: PostTuple) {
        let postDetailVC = PostDetailViewController.instantiate()
        postDetailVC.coordinator = self
        postDetailVC.postDetails = post
        navigationController.pushViewController(postDetailVC, animated: true)
    }

    // This function append and removes viewControllers
    func childDidFinish(_ child: UIViewController) {
    // This checks if the first element in the array is a viewController
    // that is a of Coordinator if it is then it removes it.
        if let index = childcoordinator.firstIndex(where: { (coordinator) -> Bool in coordinator == child }) {
            childcoordinator.remove(at: index)
        }
    }
}

#if DEBUG
extension MainCoordinator {
    var count: Int {
        return childcoordinator.count
    }
}
#endif
