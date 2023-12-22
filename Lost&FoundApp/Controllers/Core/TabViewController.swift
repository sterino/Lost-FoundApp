//
//  TabViewController.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 16.12.2023.
//

import UIKit

final class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    private func setUpTabs(){
        let mainVC = MainViewController(isSigned: true)
        let create_adVC = CreateAdViewController()
        let user_profileVC = UserProfileViewController()
        
        mainVC.navigationItem.largeTitleDisplayMode = .automatic
        create_adVC.navigationItem.largeTitleDisplayMode = .automatic
        user_profileVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: mainVC)
        let nav2 = UINavigationController(rootViewController: create_adVC)
        let nav3 = UINavigationController(rootViewController: user_profileVC)
        
        mainVC.tabBarItem = UITabBarItem(title: "Главная",
                                       image: UIImage(systemName: "house.fill"),
                                       tag: 1)
        create_adVC.tabBarItem = UITabBarItem(title: "Создать",
                                       image: UIImage(systemName: "plus.app"),
                                       tag: 2)
        user_profileVC.tabBarItem = UITabBarItem(title: "Профиль",
                                       image: UIImage(systemName: "person.fill"),
                                       tag: 3)

        
        for nav in [nav1, nav2,  nav3] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(
            [nav1, nav2,  nav3],
            animated: true
        )
    }
}

