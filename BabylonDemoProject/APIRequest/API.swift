//
//  API.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ results: Result<ModelType, Error>) -> Void

protocol API {
    func fetchJsonData(endpoint: URLEndpoint, completion: @escaping CompletionHandler)
}
