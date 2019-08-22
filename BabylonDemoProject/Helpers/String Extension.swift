//
//  String Extension.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 21/08/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension String {
    func addFullStop() -> String {
        return self + "."
    }
}
