//
//  MainCoordinator.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 29/07/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

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

    func childDidFinish(_ child: UIViewController) {
        if let index = childcoordinator.firstIndex(where: { (coordinator) -> Bool in coordinator == child }) {
            childcoordinator.remove(at: index)
        }
    }
}

#if DEBUG
extension MainCoordinator {
    var count: Int {
        print(childcoordinator.count)
        return childcoordinator.count
    }
}
#endif
