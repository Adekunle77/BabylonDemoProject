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
    @IBOutlet private weak var didTapBackBtn: UIButton!
    weak var coordinator: MainCoordinator?
    var postDetails: PostTuple?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelsSetup()
        self.buttonSetup()
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.coordinator?.childDidFinish(self)
    }

    @IBAction func didTapBackButton(_: Any) {
        self.coordinator?.popPostVC()
    }

    private func labelsSetup() {
        self.authorName?.text = postDetails?.author.name
        self.postDescription?.text = postDetails?.post.body.capitalizedFirstLetter.addFullStop()
        self.commentsCount?.text = postDetails?.commentsCount
    }

    private func buttonSetup() {
        self.didTapBackBtn.layer.cornerRadius = 20

    }
}

extension PostDetailViewController: Storyboarded {}
