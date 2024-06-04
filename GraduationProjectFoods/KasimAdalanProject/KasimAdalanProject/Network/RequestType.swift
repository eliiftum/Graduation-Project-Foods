//
//  RequestType.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import Foundation
enum URLConstants  : String {
    
    case scheme = "http"
    case base = "kasimadalan.pe.hu"
    case foods = "/yemekler/tumYemekleriGetir.php"
    case getCart = "/yemekler/sepettekiYemekleriGetir.php"
    case addFoodToCart = "/yemekler/sepeteYemekEkle.php"
    case deleteFoodToCart = "/yemekler/sepettenYemekSil.php"
    case imageBaseURL = "http://kasimadalan.pe.hu/yemekler/resimler/"
}

enum RequestType {
    case foods
    case cart
    case addFoodToCart
    case deleteFoodToCart
 
    var endPoint : URL? {
        var components = URLComponents()
        components.scheme = URLConstants.scheme.rawValue
        
        switch self {
        case .foods:
            components.host = URLConstants.base.rawValue
            components.path = URLConstants.foods.rawValue
            return components.url
        case .cart:
            components.host = URLConstants.base.rawValue
            components.path = URLConstants.getCart.rawValue
            return components.url        
        case .addFoodToCart:
            components.host = URLConstants.base.rawValue
            components.path = URLConstants.addFoodToCart.rawValue
            return components.url       
        case .deleteFoodToCart:
            components.host = URLConstants.base.rawValue
            components.path = URLConstants.deleteFoodToCart.rawValue
            return components.url
        }
    }
    
    var httpMethod : HttpMethod {
        switch self {
        case .foods:
            return .GET
        default:
            return .POST
        }
    }
}

enum HttpMethod : String {
    case GET
    case POST
}
