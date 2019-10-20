//

//  ContentStateViewModel.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 21/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit
import CoreData

// This ViewModel checks if data is available via Core Data. If there is
// no data it makes an API request to get data via the LoadManager class.
protocol ContentFetchingStateDelegate: class {
    func didUpdateWithData()
    func didFailWithErrors(_ errors: [Error])
    func isLoading()
}

final class ContentViewModel {
    private let persistedContentProvider: PersistedContentProvider!
    private let contentProvider: AllContentProvider!
    private weak var delegate: ContentFetchingStateDelegate?

    init(delegate: ContentFetchingStateDelegate) {
        self.delegate = delegate

        self.persistedContentProvider = PersistedContentProvider(dataSource: APIContentProvider())
        self.contentProvider = AllContentProvider(contentProvider: persistedContentProvider,
                                                 delegate: delegate)

        self.refresh()
    }

    private func numberOfSavedPosts() -> Int? {
        return self.persistedContentProvider.fetchAllPosts().count
    }

    private func isEmpty() -> Bool {
        return numberOfSavedPosts() == 0
    }

    func refresh() {
        if isEmpty() {
            contentProvider.fetch()
        } else {
            delegate?.didUpdateWithData()
        }
    }
}
