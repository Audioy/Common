//
//  UICollectionView+Extensions.swift
//  Common
//
//  Created by John Neumann on 14/02/2018.
//  Copyright © 2018 Audioy. All rights reserved.
//

import Foundation

// Make cell identifiers reusable for collection views
// Source: https://medium.com/@gonzalezreal/ios-cell-registration-reusing-with-swift-protocol-extensions-and-generics-c5ac4fb5b75e#.3ey5f2nvs

public protocol ReusableView: class {}

public extension ReusableView where Self: UIView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

//extension UICollectionViewCell: ReusableView {}
extension UICollectionReusableView: ReusableView {}

public extension UICollectionView {

    func register<T: UICollectionViewCell>(_: T.Type){
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T{
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else{
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    func registerHeader<T: UICollectionReusableView>(_: T.Type){
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier)
    }

    func registerFooter<T: UICollectionReusableView>(_: T.Type){
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableHeader<T: UICollectionReusableView>(forIndexPath indexPath: IndexPath) -> T{
        guard let reusableView = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue header with identifier: \(T.reuseIdentifier)")
        }
        return reusableView
    }

    func dequeueReusableFooter<T: UICollectionReusableView>(forIndexPath indexPath: IndexPath) -> T{
        guard let reusableView = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue footer with identifier: \(T.reuseIdentifier)")
        }
        return reusableView
    }
}
