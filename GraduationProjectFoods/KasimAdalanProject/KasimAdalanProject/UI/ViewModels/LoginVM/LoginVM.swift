//
//  LoginVM.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import Foundation
import RxSwift

protocol LoginVMDelegate {
    func routeToHomePage()
}

class LoginVM  {
    
    private var userInfoRepository = UserInfoRepository()
    private let disposeBag = DisposeBag()
    private var username: String = ""
    
    private var passWord : String = ""
    
    var delegate: LoginVMDelegate? 
    
    func updateUsername(username: String) {
        self.username = username
    }
    
    func updatePassWord(password: String) {
        self.passWord = password
    }
    
    func getLogin() {
        guard !username.isEmpty, !passWord.isEmpty else {
            
            AlertManager.showAlert(title: "Hata",
                                   message: "Kullanıcı adı ve şifre girmelisiniz!")
            return
        }
        checkUsernameAndPassword()
    }
    
    func checkUsernameAndPassword(){
        userInfoRepository.user
            .take(1)
            .subscribe(onNext: { [weak self] users in
                let selectedUser = users.filter { user in
                    user.username == self?.username
                }
                
                if let firstUser = selectedUser.first {
                    
                    if firstUser.password == self?.passWord, firstUser.username == self?.username {
                        self?.delegate?.routeToHomePage()
                        CacheManager.shared.saveUsername(firstUser.username)
                    } else {
                        AlertManager.showAlert(title: "Hata",
                                               message: "Kullanıcı adı ve şifre yanlış!")
                    }
                    
                }
            })
            .disposed(by: disposeBag)
    }
}
