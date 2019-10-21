//
//  ViewController.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

final class PostsViewController: UIViewController {
    @IBOutlet private var collectionView: UICollectionView!
    private let viewModel = PostsDataSource()
    weak var coordinator: ContentPresentationCoordinator?

    @IBOutlet private var _navigationItem: UINavigationItem?
    override var navigationItem: UINavigationItem {
        get { return self._navigationItem ?? super.navigationItem }
        set { }
    }

    override var title: String? {
        get { return NSLocalizedString("com.babylon.authors", comment: "") }
        set { }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        collectionViewSetUp()
    }

    deinit {
        self.coordinator?.childDidFinish(self)
    }

    @IBAction func didTapRefreshButton(_: Any) {
        viewModel.refreshData()
        self.coordinator?.start()
    }

    private func collectionViewSetUp() {
        collectionView?.delegate = viewModel
        collectionView?.dataSource = viewModel
    }
}

extension PostsViewController: ViewModelDelegate {
    func modelDidUpdateWithData() {
        collectionView.reloadData()
    }

    func showPostDetails(post: PostTuple) {
        self.coordinator?.showPostDetail(post)
    }

    func modelDidUpdateWithError(error: Error) {
        var errorArray = [Error]()
        errorArray.append(error)
        self.coordinator?.showErrors(errorArray)
    }
}

extension PostsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        sizeForItemAt _: IndexPath) -> CGSize {
        let width = view.bounds.size.width
        let height = view.bounds.size.height

        return CGSize(width: width - 30, height: height - 20)
    }
}

extension PostsViewController: Instantiatable {}
