//
//  Storyboarded.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 29/07/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

// Create protocol to instantiate a view controller from the storyboard.
protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    //  This function returns the instantiate view controller from the storyboard.
    //  To save repeated instantiation of view controllers from the main storyboard
    static func instantiate() -> Self {
        let name = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: name) as! Self // swiftlint:disable:this force_cast
    }
}
