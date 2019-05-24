//
//  CollectionViewCell.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackgroundView.addBorder(to: .bottom, with: UIColor.black.cgColor, thickness: 1.0)
    }

    func updateCell(with info: Posts) {
        title?.text = info.title
    }
}
