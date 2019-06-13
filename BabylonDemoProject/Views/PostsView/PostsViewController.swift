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
    private var stateViewController: ContentStateViewController?
    @IBOutlet private var collectionView: UICollectionView!
    private var viewModel = PostsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        collectionViewSetUp()
    }

    @IBAction func refreshData(_: Any) {
        viewModel.refreshData()
        guard let viewController = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateViewController(
            withIdentifier: "ContentStateVC"
        ) as? ContentStateViewController else { return }
        present(viewController, animated: true, completion: nil)
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
        performSegue(withIdentifier: "postDetail", sender: post)
    }

    func modelDidUpdateWithError(error: Error) {
        guard let viewController = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateViewController(
            withIdentifier: "ErrorViewVC"
        ) as? ErrorViewController else { return }

        viewController.error = error.localizedDescription
        present(viewController, animated: false, completion: nil)
    }
}

extension PostsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout
        _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let width = view.bounds.size.width
        let height = view.bounds.size.height

        return CGSize(width: width - 30, height: height - 10)
    }
}

extension PostsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailPostVC = segue.destination as? PostDetailViewController,
            let detailPost = sender as? PostTuple {
            detailPostVC.postDetails = detailPost
        }
    }
}
