//
//  ViewController.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit
import CoreData

class PostsViewController: UIViewController {

    private var stateViewController: ContentStateViewController?
    @IBOutlet weak private var collectionView: UICollectionView!
    private var viewModel = PostsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        collectionViewSetUp()
    }

    @IBAction func refreshData(_ sender: Any) {
        viewModel.refreshData()
        guard let viewController = UIStoryboard(
            name: "Main",
            bundle: nil).instantiateViewController(
            withIdentifier: "ContentStateVC") as? ContentStateViewController else { return }
        self.present(viewController, animated: true, completion: nil)
    }
    
    private func collectionViewSetUp() {
        self.collectionView?.delegate = viewModel
        self.collectionView?.dataSource = viewModel
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.collectionView?.register(nib, forCellWithReuseIdentifier: viewModel.reuseIdentifier)
    }
}

extension PostsViewController: ViewModelDelegate {
    func modelDidUpdateWithData() {
        self.collectionView.reloadData()
    }
    
    func showPostDetails(post: PostTuple) {
        self.performSegue(withIdentifier: "postDetail", sender: post)
    }
    
    func modelDidUpdateWithError(error: Error) {
        guard let viewController = UIStoryboard(
        name: "Main",
        bundle: nil).instantiateViewController(
        withIdentifier: "ErrorViewVC") as? ErrorViewController else { return }
        
        viewController.error = error.localizedDescription
        self.present(viewController, animated: false, completion: nil)
        
    }
}

extension PostsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
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
