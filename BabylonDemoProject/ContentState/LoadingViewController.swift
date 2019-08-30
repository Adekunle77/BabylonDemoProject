//
//  LoadingViewController.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

final class LoadingViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    @IBOutlet private var babylonLogo: UIImageView!
    private lazy var activityIndicator = UIActivityIndicatorView(style: .gray)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicatorSetting()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.activityIndicator.startAnimating()
    }

    override func viewDidDisappear(_ animated: Bool) {
       self.coordinator?.childDidFinish(self)
    }

    func delayPushToContentVC() {
        self.coordinator?.start()
    }

    private func activityIndicatorSetting() {
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
}

extension LoadingViewController: Storyboarded {}
