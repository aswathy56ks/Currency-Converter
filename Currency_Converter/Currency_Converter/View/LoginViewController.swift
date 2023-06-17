//
//  LoginViewController.swift
//  iOS_Test
//
//  Created by Aswathy Krishnan Sheela on 17/06/23.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    // Add the Google Sign-In implementation for login
    // ...

    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add the login button to the view
        view.addSubview(loginButton)

        // Position the login button
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func loginButtonPressed() {
        // Handle the login button press event
        // ...

        // Once the user is logged in, present the HomeCurrencySelectionViewController
        let viewModel = HomeCurrencySelectionViewModel()
        let homeCurrencySelectionVC = HomeCurrencySelectionViewController(viewModel: viewModel)
        navigationController?.pushViewController(homeCurrencySelectionVC, animated: true)
    }
}
