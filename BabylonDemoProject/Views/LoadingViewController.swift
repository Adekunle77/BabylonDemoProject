//
//  LoadingViewController.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    @IBOutlet var resetButton: UIButton!
    private lazy var activityIndicator = UIActivityIndicatorView(style: .gray)
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorSetting()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetButton?.isHidden = true
        self.activityIndicator.startAnimating()
    }

    override func viewDidDisappear(_ animated: Bool) {
       self.coordinator?.childDidFinish(self)
    }

    func activityIndicatorSetting() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .magenta
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }

    func hideObjectsInView() {
        resetButton?.isHidden = false
    }

    @IBAction private func returnToContentStateVC(_: Any) {
        self.coordinator?.start()
    }
}

extension LoadingViewController: Storyboarded {}
