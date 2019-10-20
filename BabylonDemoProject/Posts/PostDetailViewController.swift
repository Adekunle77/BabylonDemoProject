//
//  PostDetailViewController.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 16/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

final class PostDetailViewController: UIViewController {
    @IBOutlet private var authorName: UILabel!
    @IBOutlet private var postDescription: UILabel!
    @IBOutlet private var commentsCount: UILabel!

    weak var coordinator: MainCoordinator?
    var postDetails: PostTuple?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelsSetup()
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.coordinator?.childDidFinish(self)
    }

    private func labelsSetup() {
        self.authorName?.text = postDetails?.author.name
        self.postDescription?.text = postDetails?.post.body.capitalizedFirstLetter.addFullStop
        self.commentsCount?.text = postDetails?.commentsCount
    }

    override var title: String? {
        get { return self.postDetails?.author.name }
        set { }
    }
}

extension PostDetailViewController: Instantiatable {}
