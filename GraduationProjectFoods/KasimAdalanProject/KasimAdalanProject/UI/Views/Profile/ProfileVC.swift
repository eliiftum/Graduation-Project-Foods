//
//  ProfileVC.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import UIKit

class ProfileVC: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    fileprivate func prepareView() {
        self.navigationItem.hidesBackButton = true
        
        let backgroundImage = UIImageView(image: .splashBG)
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
    }

}

extension ProfileVC: StoryboardInstantiable {}
