//
//  SignUpViewController.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 18.12.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let headerView = SigninHeaderView(title: "Регистрация", subTitle: "Создайте свой аккаунт")
    
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    
    private let signUpButton = CustomButton(title: "Создать аккаунт", hasBackground: true, fontSize: .big)
    private let signInButton = CustomButton(title: "У вас уже есть аккаунт? Войти", fontSize: .med)

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setupUI()
        self.signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUI() {
        self.view.addSubview(headerView)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(signUpButton)
        self.view.addSubview(signInButton)


        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
       
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 30),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 180),
            
            self.emailField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 60),
            self.emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 55),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 22 ),
            self.passwordField.centerXAnchor.constraint(equalTo: emailField.centerXAnchor),
            self.passwordField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.signUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 22 ),
            self.signUpButton.centerXAnchor.constraint(equalTo: passwordField.centerXAnchor),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 55),
            self.signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.signInButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 22 ),
            self.signInButton.centerXAnchor.constraint(equalTo: signUpButton.centerXAnchor),
            self.signInButton.heightAnchor.constraint(equalToConstant: 44),
            self.signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),


        ])
    }
    
    @objc private func didTapSignUp() {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
                  return
              }
        
//        AuthManager.shared.signUp(name: name, username: email, password: password) { [weak self] success in
//            guard success else {
//                return
//            }
            
//        }
    }
    
    @objc private func didTapSignIn() {
//        self.navigationController?.popToRootViewController(animated: true)
        navigationController?.popViewController(animated: true)
    }
    

}
