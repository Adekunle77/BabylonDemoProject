//
//  MoldelType.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

enum ModelType {
    case posts([Posts])
    case users([User])
    case comments([Comment])
}

// ModelType conforms to Equatable for the purpose of testing.
extension ModelType: Equatable {}
