//
//  UIViewControllerExtension.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

extension Array where Element: Equatable {
    func all(where predicate: (Element) -> Bool) -> [Element] {
        return compactMap { predicate($0) ? $0 : nil }
    }
}

extension UIView {
    enum ViewSide {
        case left
        case right
        case top
        case bottom
    }

    func addBorder(to side: ViewSide, with color: CGColor, thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color

        switch side {
        case .left:
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height)
        case .top:
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness)
        }

        layer.addSublayer(border)
    }
}
