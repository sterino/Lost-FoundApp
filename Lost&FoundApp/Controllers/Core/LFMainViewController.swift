//
//  LFMainViewController.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 16.12.2023.
//

import UIKit

final class LFMainViewController: UIViewController {

    private let mainListView = LFMainListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Объявления"
        setUpView()
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
