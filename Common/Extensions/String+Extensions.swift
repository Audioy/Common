//
//  String+Extensions.swift
//  Common
//
//  Created by John Neumann on 14/02/2018.
//  Copyright © 2018 Audioy. All rights reserved.
//

import Foundation

public extension String{

    var underlined: NSAttributedString {
        get {
            let textRange = NSMakeRange(0, self.count)
            let attributedText = NSMutableAttributedString(string: self)
            attributedText.addAttribute(NSAttributedStringKey.underlineStyle , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
            return attributedText
        }
    }
    func underlined(withColour colour: UIColor) -> NSAttributedString{
        let textRange = NSMakeRange(0, self.count)
        let attributedText = NSMutableAttributedString(string: self)
        attributedText.addAttribute(NSAttributedStringKey.underlineStyle , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
        attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: colour, range: textRange)
        return attributedText
    }

    func localised(with bundle: Bundle) -> String{
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    //var localised: String { return NSLocalizedString(self, comment: "") }
}
