//
//  UITextFieldWithRegex.swift
//  Common
//
//  Created by John Neumann on 17/12/2017.
//  Copyright © 2017 Audioy. All rights reserved.
//

import UIKit

open class UITextFieldWithRegex: UITextField {

    public enum Regex: String{
        case number = "^[0-9]+$"
        case numberWithDecimalPoint = "^([0-9]+)?(\\.([0-9]+)?)?$"
    }

    private let decimalSeparator = NSLocale.current.decimalSeparator ?? "."
    private var regex: Regex

    public init(_ regex: Regex) {
        self.regex = regex
        super.init(frame: .zero)
        self.delegate = self
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UITextFieldWithRegex: UITextFieldDelegate{
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        // Allow deleting
        guard range.length == 0 else { return true }

        guard let textFieldString = textField.text as NSString? else { return false }

        var newString: String = textFieldString.replacingCharacters(in: range, with: string)
        if regex == .numberWithDecimalPoint{
            newString = newString.replacingOccurrences(of: decimalSeparator, with: ".") // Cater to the local decimal separator
        }

        return newString.isValid(forRegex: self.regex)
    }
}

private extension String {
    func isValid(forRegex regex: UITextFieldWithRegex.Regex) -> Bool {
        let regexPredicate: NSPredicate = NSPredicate(format:"SELF MATCHES %@", regex.rawValue)

        let valid = regexPredicate.evaluate(with: self)

        return valid
    }
}
