//
//  PostDetailViewController.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 16/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {

    @IBOutlet private weak var authorName: UILabel!
    @IBOutlet private weak var postDescription: UILabel!
    @IBOutlet private weak var commentsCount: UILabel!
    var postDetails: PostTuple?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorName?.text = postDetails?.author.name
        postDescription?.text = postDetails?.post.body
        commentsCount?.text = postDetails?.commentsCount
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
