//
//  TabController.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import UIKit

class TabController: UITabBarController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customizeNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = .title
        self.tabBar.unselectedItemTintColor = .gray
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title ==  "Sepet" {
            self.navigationItem.title = "Sepetim"
        } else if item.title == "Yemekler" {
            self.navigationItem.title = "Lezzet Noktası"
        } else if item.title == "Profil" {
            self.navigationItem.title = "Profilim"
        }
    }
    
    func customizeNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Lezzet Noktası"
        navigationController?.navigationBar.prefersLargeTitles = true // Navigation bar large titles
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.title]
         navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 0/255, green: 150/255, blue: 136/255, alpha: 1.0)
    }
    
}

extension TabController: StoryboardInstantiable {}
