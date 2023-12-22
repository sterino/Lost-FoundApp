//
//  MainViewController.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 16.12.2023.
//

import UIKit

final class MainViewController: UIViewController {
    private let mainListView = MainListView()
    private let isSigned: Bool
    
    init(isSigned: Bool) {
        self.isSigned = isSigned
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        if !isSigned {
            configureNavigationBar()
        }
        
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "Объявления"
        navigationItem.title = "Объявления"
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Войти", style: .plain, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        let vc = SigninViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setUpView() {
        view.addSubview(mainListView)
        NSLayoutConstraint.activate([
            mainListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mainListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    
}
