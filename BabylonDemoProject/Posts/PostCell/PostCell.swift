//
//  PostCell.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

final class PostCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!

    static let reuseIdentifier = "PostCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundView?.addBorder(to: .top, with: UIColor.gray.cgColor, thickness: 0.5)
    }

    func updateCell(with info: Posts) {
        titleLabel?.text = info.title.capitalizedFirstLetter.addFullStop
    }
}
