//
//  SigninViewController.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 18.12.2023.
//

import UIKit

class SigninViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .large)
    private let headerView = SigninHeaderView(title: "Вход", subTitle: "Войдите в свой аккаунт ")
    private let usernameField = CustomTextField(fieldType: .username)
    private let passwordField = CustomTextField(fieldType: .password)
    private let signInButton = CustomButton(title: "Войти", hasBackground: true, fontSize: .big)
    private let newUserButton = CustomButton(title: "Нет аккаунта? Создайте аккаунт", fontSize: .med)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        setupUI()
        
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        self.newUserButton.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUI() {
        view.addSubview(headerView)
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(newUserButton)
        view.addSubview(spinner)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        headerView.translatesAutoresizingMaskIntoConstraints = false
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        newUserButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: -30),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 180),
            
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
        ])
    }
    
    @objc private func didTapSignIn() {
        guard let email = usernameField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            // Вместо return можно добавить код обработки ошибки, если нужно
            return
        }
//
//        navigationController?.viewControllers = [TabViewController()]
        spinner.startAnimating()
        AuthManager.shared.signIn(username: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    
                    self?.spinner.stopAnimating()
                    self?.usernameField.layer.borderWidth = 0
                    self?.usernameField.layer.borderColor = UIColor.secondarySystemFill.cgColor
                    self?.passwordField.layer.borderWidth = 0
                    self?.passwordField.layer.borderColor = UIColor.secondarySystemFill.cgColor
                    
                    if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let tabBarController = sceneDelegate.window?.rootViewController as? TabViewController {
                        tabBarController.setUpTabs(state: AuthorizedState())
                    }
                case .failure(let error):
                    self?.spinner.stopAnimating()
                    self?.usernameField.layer.borderWidth = 2
                    self?.usernameField.layer.borderColor = UIColor.systemRed.cgColor
                    self?.passwordField.layer.borderWidth = 2
                    self?.passwordField.layer.borderColor = UIColor.systemRed.cgColor
                    // Обработка ошибки, например, показать пользователю сообщение об ошибке
                    print("Sign in error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    @objc private func didTapNewUser() {
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
