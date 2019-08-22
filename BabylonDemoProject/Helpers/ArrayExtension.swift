//
//  ArrayExtension.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    func all(where predicate: (Element) -> Bool) -> [Element] {
        return compactMap { predicate($0) ? $0 : nil }
    }
}
