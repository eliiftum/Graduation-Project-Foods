//
//  UserInfoRepository.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import CoreData
import RxSwift
import SwiftUI

class UserInfoRepository {
    private let context: NSManagedObjectContext
    private let listSubject = BehaviorSubject<[UserInfoModel]>(value: [])
    
    init(context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext) {
        self.context = context
        fetchAllUsers()
    }
    
    var user: Observable<[UserInfoModel]> {
        return listSubject.asObservable()
    }

    // Add User Info
    func addUserInfo(_ userInfoModel: UserInfoModel) {
        let userInfo = UserInfo(context: context)
        userInfo.address = userInfoModel.address
        userInfo.name = userInfoModel.name
        userInfo.password = userInfoModel.password
        userInfo.phoneNumber = userInfoModel.phoneNumber
        userInfo.surname = userInfoModel.surname
        userInfo.username = userInfoModel.username
        
        saveContext()
        fetchAllUsers()
    }
    
    // Update User Info
    func updateUserInfo(_ userInfo: UserInfo, with newData: UserInfoModel) {
        userInfo.address = newData.address
        userInfo.name = newData.name
        userInfo.password = newData.password
        userInfo.phoneNumber = newData.phoneNumber
        userInfo.surname = newData.surname
        userInfo.username = newData.username
        
        saveContext()
        fetchAllUsers()
    }
    
    // Delete User Info
    func deleteUserInfo(_ userInfo: UserInfo) {
        context.delete(userInfo)
        
        saveContext()
        fetchAllUsers()
    }
    
    // Fetch All Users
    private func fetchAllUsers() {
        let fetchRequest: NSFetchRequest<UserInfo> = UserInfo.fetchRequest()
        
        do {
            let users = try context.fetch(fetchRequest)
            let userInfoModels = users.map { userInfo in
                return UserInfoModel(
                    address: userInfo.address ?? "",
                    name: userInfo.name ?? "",
                    password: userInfo.password ?? "",
                    phoneNumber: userInfo.phoneNumber ?? "",
                    surname: userInfo.surname ?? "",
                    username: userInfo.username ?? ""
                )
            }
            listSubject.onNext(userInfoModels)
        } catch {
            print("Error fetching users: \(error)")
            listSubject.onError(error)
        }
    }
    
    // Save Context
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
                context.rollback()
            }
        }
    }
}
