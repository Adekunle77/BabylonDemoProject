//
//  String Extension.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 21/08/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

// This extension capitalizes the first character in a string.
extension String {
    var capitalizedFirstLetter: String {
        return prefix(1).localizedUppercase + localizedLowercase.dropFirst()
    }
}

extension String {
    func addFullStop() -> String {
        return self + "."
    }
}
