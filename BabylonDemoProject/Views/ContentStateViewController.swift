//
//  ContentStateViewController.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

protocol ContentStateErrorDelegate: class {
    func displayErrorMessage(error: Error)
}

class ContentStateViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    var viewModelDelegate = ContentStateViewModel()
    weak var delegate: ContentStateErrorDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModelDelegate.delegate = self
        self.viewModelDelegate.loadData()
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.coordinator?.childDidFinish(self)
    }
}

extension ContentStateViewController: Storyboarded {}

extension ContentStateViewController: ContentStateViewModelDelegate {
    func didUpdateWithError(error: [Error]) {
        self.coordinator?.pushErrorVC(with: error)
    }
    func didUpdateWithData() {
        self.coordinator?.pushPostVC()
    }

    func dataLoading() {
        self.coordinator?.pushLoadingVC()
    }
}
