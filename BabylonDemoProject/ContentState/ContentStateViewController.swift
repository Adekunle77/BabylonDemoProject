//
//  ContentStateViewController.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

class ContentStateViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    private var viewModel = ContentStateViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        self.viewModel.loadData()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
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

    func dataIsLoading() {
        self.coordinator?.pushLoadingVC()
    }
}
