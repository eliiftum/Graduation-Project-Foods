//
//  UserInfoModel.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import Foundation

class UserInfoModel {
    init(address: String = "" ,
         name: String = "",
         password: String = "",
         phoneNumber: String = "",
         surname: String = "",
         username: String = "") {
        self.address = address
        self.name = name
        self.password = password
        self.phoneNumber = phoneNumber
        self.surname = surname
        self.username = username
    }
    
    var address: String
    var name: String
    var password: String
    var phoneNumber: String
    var surname: String
    var username: String
}
