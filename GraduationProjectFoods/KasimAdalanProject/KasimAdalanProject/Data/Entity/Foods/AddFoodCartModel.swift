//
//  AddFoodCartModel.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import Foundation

struct AddFoodCartModel: Codable {
    let username : String
    let yemekSepetId : String? = nil
    let yemekSiparisAdet: Int
    let yemekID: String? = nil
    let yemekAdi, yemekResimAdi: String
    let yemekFiyat: Int

    enum CodingKeys: String, CodingKey {
        case username = "kullanici_adi"
        case yemekSepetId = "sepet_yemek_id"
        case yemekSiparisAdet = "yemek_siparis_adet"
        case yemekID = "yemek_id"
        case yemekAdi = "yemek_adi"
        case yemekResimAdi = "yemek_resim_adi"
        case yemekFiyat = "yemek_fiyat"
    }
}
