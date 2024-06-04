//
//  CacheManager.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import Foundation

class CacheManager {

    static let shared = CacheManager()
    private let userDefaults = UserDefaults.standard
    
    private init() {}
    
    func saveUsername(_ username: String) {
        userDefaults.set(username, forKey: UserDefaultsKey.username.rawValue)
        userDefaults.synchronize()
    }
    
    func getUsername() -> String? {
        return userDefaults.string(forKey: UserDefaultsKey.username.rawValue)
    }
    
    func removeUsername() {
        userDefaults.removeObject(forKey: UserDefaultsKey.username.rawValue)
        userDefaults.synchronize()
    }
}

enum UserDefaultsKey: String {
    case username
}
