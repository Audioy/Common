//
//  ViewController.swift
//  CommonTestHostApp
//
//  Created by John Neumann on 17/12/2017.
//  Copyright © 2017 Audioy. All rights reserved.
//

import UIKit
import Common

class ViewController: UIViewController {

    private lazy var textField: UITextFieldWithRegex = {
        let tf = UITextFieldWithRegex(.number)
        tf.backgroundColor = UIColor.white
        return tf
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        view.backgroundColor = UIColor.red
        view.addSubview(textField)
        NSLayoutConstraint.useAndActivate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            textField.heightAnchor.constraint(equalToConstant: 33)
            ])

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

