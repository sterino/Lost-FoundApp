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
    private let signInButton = LFCustomButton(title: "Войти", hasBackground: true, fontSize: .big)
    private let newUserButton = LFCustomButton(title: "Нет аккаунта? Создайте аккаунт", fontSize: .med)
    private let forgotPasswordButton = LFCustomButton(title: "Забыли пароль?",fontSize: .small)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setupUI()
        
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        self.newUserButton.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
        self.forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true

    }
    
    private func setupUI() {
        self.view.addSubview(headerView)
        self.view.addSubview(usernameField)
        self.view.addSubview(passwordField)
        self.view.addSubview(signInButton)
        self.view.addSubview(newUserButton)
        self.view.addSubview(forgotPasswordButton)

        headerView.translatesAutoresizingMaskIntoConstraints = false
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        newUserButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: -50),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 222),
            
            self.usernameField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 60),
            self.usernameField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.usernameField.heightAnchor.constraint(equalToConstant: 55),
            self.usernameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 22 ),
            self.passwordField.centerXAnchor.constraint(equalTo: usernameField.centerXAnchor),
            self.passwordField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 22 ),
            self.signInButton.centerXAnchor.constraint(equalTo: passwordField.centerXAnchor),
            self.signInButton.heightAnchor.constraint(equalToConstant: 55),
            self.signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.newUserButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 11 ),
            self.newUserButton.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor),
            self.newUserButton.heightAnchor.constraint(equalToConstant: 44),
            self.newUserButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.forgotPasswordButton.topAnchor.constraint(equalTo: newUserButton.bottomAnchor, constant: 6 ),
            self.forgotPasswordButton.centerXAnchor.constraint(equalTo: newUserButton.centerXAnchor),
            self.forgotPasswordButton.heightAnchor.constraint(equalToConstant: 44),
            self.forgotPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
        ])
    }
    
    @objc private func didTapSignIn() {
        guard let email = usernameField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            // Вместо return можно добавить код обработки ошибки, если нужно
            return
        }

        AuthManager.shared.signIn(username: email, password: password) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    let vc = LFUserProfileViewController()
                    
                    self?.navigationController?.pushViewController(vc, animated: true)
                    
                    
                }

            case .failure(let error):
                // Обработка ошибки, например, показать пользователю сообщение об ошибке
                print("Sign in error: \(error.localizedDescription)")
            }
        }
    }
    
    @objc private func didTapNewUser() {
        let vc = LFSignupViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapForgotPassword() {
        let vc = LFForgotPasswordViewController()
        vc.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
