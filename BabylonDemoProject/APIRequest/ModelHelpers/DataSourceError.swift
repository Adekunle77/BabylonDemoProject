//
//  DataSourceError.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

enum DataSourceError: Error {
    case fetal(String)
    case network(Error)
    case noData
    case dataError(Error)
    case jsonParseError(Error)
}
