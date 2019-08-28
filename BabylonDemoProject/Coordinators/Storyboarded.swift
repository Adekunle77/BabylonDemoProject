//
//  Storyboarded.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 29/07/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

// Create protocol to instantiate ViewController from storyboard's
protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    //  This function returns the instantiate ViewController from the storyboard.
    //  This is done to save repeating instantiating every ViewController
    static func instantiate() -> Self {
        let name = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: name) as! Self // swiftlint:disable:this force_cast
    }
}
