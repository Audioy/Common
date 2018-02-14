//
//  Dictionary+Extensions.swift
//  Common
//
//  Created by John Neumann on 14/02/2018.
//  Copyright © 2018 Audioy. All rights reserved.
//

import Foundation

public extension Dictionary {
    init(_ keys: [Key], _ values: [Value]) {
        self.init()
        for (key, value) in zip(keys, values) {
            self[key] = value
        }
    }
}
