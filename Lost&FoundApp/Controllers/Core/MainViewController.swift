//
//  MainViewController.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 16.12.2023.
//

import UIKit

final class MainViewController: UIViewController {
    private let mainListView = MainListView()
    private let mainFilterView = MainFilterView()
    private let isSigned: Bool
    var selectedValue = 1
 
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
        mainFilterView.delegate = mainListView
        mainListView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "Объявления"
        navigationItem.title = "Объявления"
        mainListView.updateData()
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Войти", style: .plain, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        let vc = SigninViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setUpView() {
        view.addSubview(mainFilterView)
        view.addSubview(mainListView)
        NSLayoutConstraint.activate([
            mainFilterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5),
            mainFilterView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mainFilterView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mainFilterView.heightAnchor.constraint(equalToConstant: 200),
            
            mainListView.topAnchor.constraint(equalTo: mainFilterView.bottomAnchor),
            mainListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mainListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    


}

extension MainViewController: MainListViewDelegate {
    func didSelectAdCell(model: MainCollectionViewCellViewModel) {
        let vc = AdDetailedViewController(model: model)
        navigationController?.pushViewController(vc, animated: true)
    }
}
