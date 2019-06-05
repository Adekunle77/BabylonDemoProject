//
//  HttpRequest.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

 class APIRequest: API {
    
    func fetchJSONdata(endPoint: URLEndpoint, completion: @escaping CompletionHandler) {
        guard let url = endPoint.url else { return }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
    
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.network(error)))
                }
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            
            do {
                if endPoint.path == Paths.authorUrlPath {
                    if let data = try Parse.authorData(data: data) {
                        DispatchQueue.main.async {
                            completion(.success(.authors(data)))
                        }
                    }
                }
                if endPoint.path == Paths.commentsUrlPath {
                    if let data = try Parse.commentsData(data: data) {
                        DispatchQueue.main.async {
                            completion(.success(.comments(data)))
                        }
                    }
                }
                    
                if endPoint.path == Paths.postsUrlPath {

                    if let data = try Parse.titleData(data: data) {
                        DispatchQueue.main.async {
                            completion(.success(.posts(data)))
                        }
                    }
                }
                
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(.dataError(error)))
                }
            }
        }
        task.resume()
    }
}

