//
//  ViewController.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.navigationController?.pushViewController(LoginVC.instantiateFromStoryboard(), 
                                                          animated: true)
        })
    }


}

