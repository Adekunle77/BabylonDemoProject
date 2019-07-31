//
//  ViewController.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import CoreData
import UIKit

class PostsViewController: UIViewController {
    weak var coordinator: MainCoordinator? 
    private var stateViewController: ContentStateViewController?
    @IBOutlet private var collectionView: UICollectionView!
    private var viewModel = PostsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        collectionViewSetUp()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.coordinator?.childDidFinish(self)
    }

    @IBAction func refreshData(_: Any) {
        viewModel.refreshData()
        self.coordinator?.start()
    }

    private func collectionViewSetUp() {
        collectionView?.delegate = viewModel
        collectionView?.dataSource = viewModel
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: viewModel.reuseIdentifier)
    }
}

extension PostsViewController: ViewModelDelegate {
    func modelDidUpdateWithData() {
        collectionView.reloadData()
    }

    func showPostDetails(post: PostTuple) {
        self.coordinator?.pushPostDetailVC(with: post)
    }

    func modelDidUpdateWithError(error: Error) {
        var arrayArray = [Error]()
        arrayArray.append(error)
        self.coordinator?.pushErrorVC(with: arrayArray)
    }
}

extension PostsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        sizeForItemAt _: IndexPath) -> CGSize {
        let width = view.bounds.size.width
        let height = view.bounds.size.height

        return CGSize(width: width - 30, height: height - 10)
    }
}

extension PostsViewController: Storyboarded {}
