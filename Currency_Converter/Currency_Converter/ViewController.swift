//
//  ViewController.swift
//  iOS_Test
//
//  Created by Aswathy Krishnan Sheela on 17/06/23.
//

import UIKit

class ViewController: UIViewController {

    let loginVC = LoginViewController()
    let navigationVC = UINavigationController(rootViewController: LoginViewController())

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the navigation controller
        addChild(navigationVC)
        view.addSubview(navigationVC.view)
        navigationVC.didMove(toParent: self)
    }
}
