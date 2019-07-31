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
    var childcoordinator: [UIViewController] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
