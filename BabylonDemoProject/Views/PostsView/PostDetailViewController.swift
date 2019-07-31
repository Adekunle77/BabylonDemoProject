//
//  PostDetailViewController.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 16/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    @IBOutlet private var authorName: UILabel!
    @IBOutlet private var postDescription: UILabel!
    @IBOutlet private var commentsCount: UILabel!
    var postDetails: PostTuple?

    override func viewDidLoad() {
        super.viewDidLoad()
        authorName?.text = postDetails?.author.name
        postDescription?.text = postDetails?.post.body
        commentsCount?.text = postDetails?.commentsCount
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.coordinator?.childDidFinish(self)
    }

    @IBAction func backButton(_: Any) {
        self.coordinator?.pushPostVC()
    }
}

extension PostDetailViewController: Storyboarded {}
