//
//  ErrorViewController.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

final class ErrorViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    @IBOutlet private var errorButton: UIButton!
    @IBOutlet private var errorUILabel: UILabel!
    var errors = [Error]()

    override func viewDidLoad() {
        super.viewDidLoad()
        errorUILabel?.text = getLocalizedDescription(from: errors)
        buttonSetup()
    }

    deinit {
        self.coordinator?.childDidFinish(self)
    }

    @IBAction private func didTapPushLoadingVC() {
        coordinator?.start()
    }

    func buttonSetup() {
        errorButton.layer.cornerRadius = 20
    }

    private func getLocalizedDescription(from errors: [Error]) -> String {
        let errors = removeDuplicates(from: errors)
        var localizedDescription = String()
        for error in errors {
            localizedDescription += "\(error) \n"
        }
        return localizedDescription
    }

    private func removeDuplicates(from errors: [Error]) -> Set<String> {
        var array = Set<String>()
        for error in errors {
            array.insert(error.localizedDescription)
        }
        return array
    }
}

extension ErrorViewController: Instantiatable {}
