//
//  DataSourceError.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

enum DataSourceError: Error {
    case fatal(String)
    case network(Error)
    case noData
    case dataError(Error)
    case jsonParseError(Error)
}

extension DataSourceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .fatal:
            return NSLocalizedString("FATAL ERROR! \n There seems to be fatal error!",
                                     comment: "Fatal Error")
        case .network:
            return NSLocalizedString("NETWORK ERROR! \n There is a network connection error!",
                                     comment: "Network connection error")
        case .noData:
            return NSLocalizedString("NO INFORMATION \n There is no information available!",
                                     comment: "No information")
        case .dataError:
            return NSLocalizedString("INFORMATION ERROR \n There is an error with the information!",
                                     comment: "Information Error")
        case .jsonParseError:
            return NSLocalizedString("INFORMATION ERROR! \n There is a error downloading the information!",
                                     comment: "Downloading error")
        }
    }
}
