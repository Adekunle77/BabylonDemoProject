//
//  ErrorViewController.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {
    weak var coordinator: MainCoordinator? 
    @IBOutlet var errorUILabel: UILabel!
    var error: String?
    var errors = [Error]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let stringedError = convertLoclizedToString(error: errors)
        displayError(error: stringedError)
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.coordinator?.childDidFinish(self)
    }

    @IBAction func returnToLoadingView(_: Any) {
        self.coordinator?.pushLoadingVC()

//        present(viewController, animated: true, completion: {
//      //      viewController.hideObjectsInView()
//        })
    }

    func convertLoclizedToString(error: [Error]) -> String {
        var errorMessage = String()
        for message in error {
            errorMessage += "\(message.localizedDescription) \n"
        }
        return errorMessage
    }

    func displayError(error: String) {
        errorUILabel?.text = error
    }

}

extension ErrorViewController: Storyboarded {}
