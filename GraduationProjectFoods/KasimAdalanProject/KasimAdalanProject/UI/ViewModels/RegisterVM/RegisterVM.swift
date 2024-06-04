//
//  RegisterVM.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import Foundation
import RxSwift

protocol RegisterVMDelegate {
    func finishRegister()
}
class RegisterVM {
    private var registerModel = RegisterModel()
    private var userInfoRepository = UserInfoRepository()
    private let disposeBag = DisposeBag()
    
    var delegate: RegisterVMDelegate?
    
    func updateUsername(userName: String) {
        registerModel.username = userName
    }
    
    func updateName(name: String) {
        registerModel.name = name
    }
    
    func updatesurname(surname: String) {
        registerModel.surname = surname
    }
    
    func updatePhoneNumber(phoneNumber: String) {
        registerModel.phoneNumber = phoneNumber
    }
    
    func updateAddress(address: String) {
        registerModel.address = address
    }
    
    func updatePassword(password: String) {
        registerModel.password = password
    }
    
    func updateRePassword(password: String) {
        registerModel.rePassword = password
    }
    
    func getRegister(){
        guard !registerModel.username.isEmpty,
              !registerModel.name.isEmpty,
              !registerModel.surname.isEmpty,
              !registerModel.phoneNumber.isEmpty,
              !registerModel.address.isEmpty,
              !registerModel.password.isEmpty,
              !registerModel.rePassword.isEmpty else {
            AlertManager.showAlert(title: "Hata", message: "Bütün değerler dolu olmalıdır!")
            return
        }
        
        guard registerModel.password == registerModel.rePassword else {
            AlertManager.showAlert(title: "Dikkat", message: "Şifreler aynı değildir!")
            return
        }
        
        let userInfoModel = registerModel as UserInfoModel
        
        userInfoRepository.addUserInfo(userInfoModel)
        
        self.delegate?.finishRegister()
        
    }
    
}
