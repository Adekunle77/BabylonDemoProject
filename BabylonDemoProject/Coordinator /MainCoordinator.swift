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
    
    var childcoordinator = [UIViewController]()
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

    func didFinishWithView(_ child: Coordinator?) {
        for (index, coordinator) in self.childcoordinator.enumerated() {
            if coordinator === child {
                childcoordinator.remove(at: index)
                break
            }
        }
    }

    func pushPostVC() {
        let postVC = PostsViewController.instantiate()
        postVC.coordinator = self
        childcoordinator.append(postVC)
        navigationController.pushViewController(postVC, animated: true)
    }

    func pushErrorVC(with error: [Error]) {
        let errorVC = ErrorViewController.instantiate()
        errorVC.errors = error
        errorVC.coordinator = self
        childcoordinator.append(errorVC)
        navigationController.pushViewController(errorVC, animated: false)
    }

    func pushLoadingVC() {
        let loadingVC = LoadingViewController()
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
        for (index, coordinator) in childcoordinator.enumerated() {
            if coordinator === child {
                childcoordinator.remove(at: index)
            }
        }
    }

//    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
//        if navigationController.viewControllers.contains(fromViewController) {
//            return
//        }
//        if let postDetailVC = fromViewController as? PostDetailViewController {
//            print(childcoordinator.count)
//            childDidFinish(postDetailVC)
//        }
//        if let postsVC = fromViewController as? PostsViewController {
//            childDidFinish(postsVC)
//        }
//    }
}
