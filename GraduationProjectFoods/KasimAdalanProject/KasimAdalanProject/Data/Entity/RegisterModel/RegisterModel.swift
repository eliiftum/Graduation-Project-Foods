//
//  RegisterModel.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import Foundation

class RegisterModel: UserInfoModel {
    var rePassword: String
    init(rePassword: String = "") {
        self.rePassword = rePassword
    }
}
