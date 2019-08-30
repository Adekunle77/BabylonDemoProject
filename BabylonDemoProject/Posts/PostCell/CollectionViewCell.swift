//
//  CollectionViewCell.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var cellBackgroundView: UIView!
    static let reuseIdentifier = "Cell"

    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackgroundView.addBorder(to: .top, with: UIColor.gray.cgColor, thickness: 0.5)
    }

    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }

    func updateCell(with info: Posts) {
        title?.text = info.title.capitalizingFirstLetter().addFullStop()
    }
}
