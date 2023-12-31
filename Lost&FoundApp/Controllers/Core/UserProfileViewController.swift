//
//  UserProfileViewController.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 16.12.2023.
//

import UIKit

final class UserProfileViewController: UIViewController {

    // MARK: - Properties

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "String"
        return label
    }()

    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "string@string.com"
        return label
    }()

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "profile_image_placeholder")
        return imageView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        view.backgroundColor = .systemBackground
        title = "Профиль"
        profileImageView.layer.cornerRadius = 60
        profileImageView.clipsToBounds = true
        navigationController?.navigationBar.isHidden = false
        let rightBarButton = UIBarButtonItem(title: "Выйти", style: .plain, target: self, action: #selector(rightBarButtonTapped))
        
        // Установка UIBarButtonItem в правой части навигационного бара
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func rightBarButtonTapped() {
        UserDefaults.standard.removeObject(forKey: "access_token")
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let tabBarController = sceneDelegate.window?.rootViewController as? TabViewController {
            tabBarController.setUpTabs(state: UnauthorizedState())
        }
    }
    
    // MARK: - Private Methods

    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)

        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),

            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
