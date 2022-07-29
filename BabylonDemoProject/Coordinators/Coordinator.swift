//
//  Coordinator.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 29/07/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    func start()
    // not sure childDidFinish really makes much sense
    func childDidFinish(_ child: UIViewController)
}
