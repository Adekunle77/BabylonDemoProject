//
//  LoadManager.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 12/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

// This probably should not exist as it means the app start up is very slow
// because you fetch everything in one go. It would be much better to fetch only
// what you need when you need it. The app will feel faster and use less data.
final class AllContentProvider {
    private let contentProvider: PersistedContentProvider
    private weak var delegate: ContentFetchingStateDelegate?

    init(contentProvider: PersistedContentProvider,
         delegate: ContentFetchingStateDelegate?) {
        self.contentProvider = contentProvider
        self.delegate = delegate
    }

    func fetch() {
        self.delegate?.isLoading()

        let dispatchGroup = DispatchGroup()

        var errorsArray = [Error]()

        dispatchGroup.enter()

        contentProvider.fetch(.posts, completion: { result in
            switch result {
            case let .failure(error):
                errorsArray.append(error)
            case .success: break
            }
            dispatchGroup.leave()
        })

        dispatchGroup.enter()
        contentProvider.fetch(.users, completion: { result in
            switch result {
            case let .failure(error):
                errorsArray.append(error)
            case .success: break
            }
            dispatchGroup.leave()
        })

        dispatchGroup.enter()
        contentProvider.fetch(.comments, completion: { result in
            switch result {
            case let .failure(error):
                errorsArray.append(error)
            case .success: break
            }
            dispatchGroup.leave()
        })

        dispatchGroup.notify(queue: .main) {
            if errorsArray.count > 0 {
                self.delegate?.didFailWithErrors(errorsArray)
            } else {
                self.delegate?.didUpdateWithData()
            }
        }
    }
}
