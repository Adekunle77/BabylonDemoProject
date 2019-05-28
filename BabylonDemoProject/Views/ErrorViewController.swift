//
//  ErrorViewController.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {
    
    @IBOutlet weak var errorUILabel: UILabel!
    var error: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayError(error: error ?? "There is an Error")
    }
    func displayError(error: String) {
        errorUILabel?.text = error
    }
    
    @IBAction func returnToLoadingView(_ sender: Any) {
        guard let viewController = UIStoryboard(
            name: "Main",
            bundle: nil).instantiateViewController(
            withIdentifier: "LoadingViewVC") as? LoadingViewController else { return }
        
        self.present(viewController, animated: true, completion: {
            viewController.hideObjectsInView()
        })
    }
}


