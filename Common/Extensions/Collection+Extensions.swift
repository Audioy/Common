//
//  Collection+Extensions.swift
//  Common
//
//  Created by John Neumann on 14/02/2018.
//  Copyright © 2018 Audioy. All rights reserved.
//

import Foundation

// This function makes sure the index is in the array by using the "safe" keyword
// Example: if let item = array[safe: index] { .. }
// Source: http://stackoverflow.com/questions/25329186/safe-bounds-checked-array-lookup-in-swift-through-optional-bindings
public extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}
