//
//  API.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

protocol ContentProvider {
    typealias Completion = (_ results: Result<ModelCollection, Error>) -> Void

    func fetch(_ contentType: ContentType, completion: @escaping Completion)
}
