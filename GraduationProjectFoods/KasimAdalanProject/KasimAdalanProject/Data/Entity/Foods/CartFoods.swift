//
//  CartFoods.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import Foundation

struct CartFoodsRequest: Codable {
    let username : String
    enum CodingKeys: String, CodingKey {
        case username = "kullanici_adi"
    }
}
   
struct FoodsCart: Codable {
    var yemekSepetId: String?
    var yemekAdi: String?
    var yemekResimAdi: String?
    var yemekFiyat: String?
    var yemekSiparisAdet: String?
    var username: String?


    enum CodingKeys: String, CodingKey {
        case yemekSepetId = "sepet_yemek_id"
        case yemekAdi = "yemek_adi"
        case yemekResimAdi = "yemek_resim_adi"
        case yemekSiparisAdet = "yemek_siparis_adet"
        case yemekFiyat = "yemek_fiyat"
        case username = "kullanici_adi"
    }
}

struct CartFoodsResponse: Codable {
    var yemekler: [FoodsCart]?
    var success: Int?
    enum CodingKeys: String, CodingKey {
        case yemekler = "sepet_yemekler"
        case success = "success"
    }
}
