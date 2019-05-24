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
    //var load: CoreDataLoadManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  load = CoreDataLoadManager()
        viewModel.delegate = self
        collectionViewSetUp()
    }

    @IBAction func testAction(_ sender: Any) {
        viewModel.refreshData()
    }
    
    private func collectionViewSetUp() {
        self.collectionView?.delegate = viewModel
        self.collectionView?.dataSource = viewModel
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.collectionView?.register(nib, forCellWithReuseIdentifier: viewModel.reuseIdentifier)
    }
}

extension PostsViewController: ViewModelDelegate {
    func showPostDetails(post: PostTuple) {
        self.performSegue(withIdentifier: "postDetail", sender: post)
    }
    
    func modelDidUpdateData() {
        self.collectionView.reloadData() 
    }
    
    func modelDidUpdateWithError(error: Error) {
        let testString = error.localizedDescription
        let errorVC = ErrorViewController()
        errorVC.errorUILabel?.text = testString
       self.stateViewController?.transtion(to: .failed, identifiers: .errorView)
    }
}

extension PostsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
