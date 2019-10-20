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
    @IBOutlet weak var refreshButton: UIButton!
    private let viewModel = PostsDataSource()
    weak var coordinator: ContentPresentationCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        collectionViewSetUp()
        buttonSetup()
    }

    deinit {
        self.coordinator?.childDidFinish(self)
    }

    func buttonSetup() {
        self.refreshButton.layer.cornerRadius = 20
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
