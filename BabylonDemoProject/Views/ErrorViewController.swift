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
        
    }
    func displayError(error: String) {
        errorUILabel?.text = error
    }
}


