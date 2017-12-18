//
//  UIViewControllerWithBackButton.swift
//  Common
//
//  Created by Audioy Ltd on 10/12/2017.
//  Copyright © 2017 Audioy. All rights reserved.
//

import UIKit

open class UIViewControllerWithBackButton: UIViewController {

    public enum BackAction{
        case pop
        case dismiss
    }

    let backAction: BackAction

    private(set) lazy var backButton: UIButton = {
        let backButton = UIButton()
        backButton.clipsToBounds = true
        backButton.contentHorizontalAlignment = .right
        backButton.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        backButton.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        return backButton
    }()

    public init(withBackAction backAction: BackAction) {
        self.backAction = backAction
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(backButton)

        let bundle = Bundle(for: UIViewControllerWithBackButton.self)

        switch backAction {
        case .pop:
            backButton.setAttributedTitle("viewcontroller+backbutton:button:back".localised(with: bundle).underlined, for: .normal)
            backButton.addTarget(self, action: #selector(pop), for: .touchUpInside)
            NSLayoutConstraint.useAndActivate([
                backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4)
                ])
            break
        case .dismiss:
            backButton.setAttributedTitle("viewcontroller+backbutton:button:dismiss".localised(with: bundle).underlined, for: .normal)
            backButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
            NSLayoutConstraint.useAndActivate([
                backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                backButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4)
                ])
            break
        }
    }

    @objc private func pop(){
        navigationController?.popViewController(animated: true)
    }

    @objc private func dismissViewController(){
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
