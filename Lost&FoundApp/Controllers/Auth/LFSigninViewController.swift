//
//  LFSigninViewController.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 18.12.2023.
//

import UIKit

class LFSigninViewController: UIViewController {
    private let headerView = LFSigninHeaderView(title: "Вход", subTitle: "Войдите в свой аккаунт ")
    private let usernameField = LFCustomTextField(fieldType: .username)
    private let passwordField = LFCustomTextField(fieldType: .password)
    private let emailField = LFCustomTextField(fieldType: .email)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUI() {
        self.view.addSubview(headerView)
        self.view.addSubview(usernameField)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)

        headerView.translatesAutoresizingMaskIntoConstraints = false
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: -50),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 222),
            
            self.usernameField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 60),
            self.usernameField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.usernameField.heightAnchor.constraint(equalToConstant: 55),
            self.usernameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 22),
            self.emailField.centerXAnchor.constraint(equalTo: usernameField.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 55),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 22 ),
            self.passwordField.centerXAnchor.constraint(equalTo: emailField.centerXAnchor),
            self.passwordField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85)
        ])
    }
}
