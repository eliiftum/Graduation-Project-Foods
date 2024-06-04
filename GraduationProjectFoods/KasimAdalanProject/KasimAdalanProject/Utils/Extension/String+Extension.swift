//
//  String+Extension.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import Foundation
extension String {
    func removingNonTurkishCharacters() -> String {
        let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnoprstuvyzABCDEFGHIJKLMNOPRSTUVYZ")
        return self.components(separatedBy: allowedCharacterSet.inverted).joined()
    }
    
    var imageUrlGenerator : String {
        let url = URLConstants.imageBaseURL.rawValue + self
        return url
    }
}
