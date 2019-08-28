//
//  HttpRequest.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

class APIRequest: API {
    func fetchJSONData(endpoint: URLEndpoint, completion: @escaping CompletionHandler) {
        guard let url = endpoint.url else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                switch (error, data) {
                case let (error?, _):
                    completion(.failure(DataSourceError.network(error)))
                case let (_, data?):
                    completion(Result { try endpoint.parse(data) })
                default:
                    completion(.failure(DataSourceError.noData))
                }
            }
        }
        task.resume()
    }
}
