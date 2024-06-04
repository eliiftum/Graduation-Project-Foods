//
//  FoodsModel.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import Foundation
class Foods: Codable {
    let yemekler: [Food]
    let success: Int
}

class Food: Codable {
    let yemekID, yemekAdi, yemekResimAdi, yemekFiyat: String

    enum CodingKeys: String, CodingKey {
        case yemekID = "yemek_id"
        case yemekAdi = "yemek_adi"
        case yemekResimAdi = "yemek_resim_adi"
        case yemekFiyat = "yemek_fiyat"
    }
}
