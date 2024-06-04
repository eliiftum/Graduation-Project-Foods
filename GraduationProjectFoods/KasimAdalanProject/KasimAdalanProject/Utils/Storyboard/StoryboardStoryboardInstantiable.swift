//
//  Storyboard+Extension.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import UIKit

protocol StoryboardInstantiable {
    static var storyboardName: String { get }
}

extension StoryboardInstantiable where Self: UIViewController {
    static var storyboardName: String {
        return String(describing: self)
    }

    static func instantiateFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: storyboardName) as! Self
    }
}
