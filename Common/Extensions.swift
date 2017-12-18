//
//  Extensions.swift
//  Common
//
//  Created by Audioy Ltd on 10/12/2017.
//  Copyright © 2017 Audioy. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor{
    // Class because it is implemented by a class
    class var ghostWhite: UIColor { return UIColor.hex("F8F8FF") }

    class var superRed: UIColor { return UIColor.red }
    
    class var random: UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    class func hex(_ hex:String, alpha:CGFloat = 1.0) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            let index = cString.index(cString.startIndex, offsetBy: 1)
            cString = String(cString[index...])
        }
        
        if cString.count != 6{
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    var invert: UIColor {
        var red         :   CGFloat  =   255.0
        var green       :   CGFloat  =   255.0
        var blue        :   CGFloat  =   255.0
        var alpha       :   CGFloat  =   1.0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        red     =   255.0 - (red * 255.0)
        green   =   255.0 - (green * 255.0)
        blue    =   255.0 - (blue * 255.0)
        
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}

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
