//
//  DeleteFoods.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import Foundation

struct DeleteFoodsModel: Codable {
    let yemekSepetId : Int
    let username: String
    
    enum CodingKeys: String, CodingKey {
        case yemekSepetId = "sepet_yemek_id"
        case username = "kullanici_adi"
    }
}
