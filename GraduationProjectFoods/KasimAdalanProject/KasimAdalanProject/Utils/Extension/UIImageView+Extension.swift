//
//  UIImageView+Extension.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with urlString: String, placeholder: UIImage? = nil, completion: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL string.")
            self.image = placeholder
            return
        }
        
        self.kf.setImage(with: url, placeholder: placeholder, options: nil, completionHandler:  { result in
            switch result {
            case .success(let value):
                print("Image successfully retrieved: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Error retrieving image: \(error)")
            }
            completion?(result)
        })
    }
}
