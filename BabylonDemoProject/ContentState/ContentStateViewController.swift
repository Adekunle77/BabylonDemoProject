//
//  ContentStateViewController.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

// This class controls which view is to be displayed depending if is any is any data, errors
// or if loading is required.
final class ContentStateViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    private lazy var viewModel = ContentViewModel(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.refresh()
    }

    deinit {
        self.coordinator?.childDidFinish(self)
    }
}

extension ContentStateViewController: Instantiatable {}

extension ContentStateViewController: ContentFetchingStateDelegate {

    func didFailWithErrors(_ errors: [Error]) {
        self.coordinator?.showErrors(errors)
    }

    func didUpdateWithData() {
        self.coordinator?.showPosts()
    }

    func isLoading() {
        self.coordinator?.showLoading()
    }
}
