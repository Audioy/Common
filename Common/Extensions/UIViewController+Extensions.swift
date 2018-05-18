//
//  UIViewController+Extensions.swift
//  Common
//
//  Created by John Neumann on 18/05/2018.
//  Copyright © 2018 Audioy. All rights reserved.
//

import Foundation

public extension UIViewController {
    // Source: https://medium.com/@johnsundell/using-child-view-controllers-as-plugins-in-swift-458e6b277b54
    func add(_ child: UIViewController) {
        addChildViewController(child)
        view.addSubview(child.view)
        child.didMove(toParentViewController: self)
    }
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParentViewController: nil)
        removeFromParentViewController()
        view.removeFromSuperview()
    }
}
