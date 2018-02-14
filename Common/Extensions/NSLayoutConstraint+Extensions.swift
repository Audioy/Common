//
//  NSLayoutConstraint+Extensions.swift
//  Common
//
//  Created by John Neumann on 14/02/2018.
//  Copyright © 2018 Audioy. All rights reserved.
//

import Foundation

public extension NSLayoutConstraint {

    public class func useAndActivate(_ constraints: [NSLayoutConstraint]) {
        var views: [UIView] = []
        for constraint in constraints {
            if let view = constraint.firstItem as? UIView {
                if views.contains(view) == false{
                    views.append(view)
                }
            }
        }
        for view in views{
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        activate(constraints)
    }
}
