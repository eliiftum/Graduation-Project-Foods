//
//  CartVM.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 3.06.2024.
//

import Foundation
import Alamofire
protocol CartVMDelegate {
    func updateCartCollection(foods:[FoodsCart])
}

class CartVM {
    var delegate: CartVMDelegate?
    func getCartProducts(){
        let params = ["kullanici_adi": CacheManager.shared.getUsername() ?? "elif_tum"]
        NetworkManager.shared.requestAF(with: .cart, params: params) {[weak self](response: Result<CartFoodsResponse, NetworkError>) in
            
            switch response {
            case .success(let model):
                if let yemekler = model.yemekler {
                    self?.delegate?.updateCartCollection(foods: yemekler)
                }
                
            case .failure(let failure):
                _ = failure
            }
        }
    }
    
    
    func orderDeleteSingle(sepetId: String, username: String) {
        let usernasme = CacheManager.shared.getUsername() ?? "elif.tum"
        let params: Parameters = ["sepet_yemek_id": Int(sepetId) ?? 0, "kullanici_adi": username]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response { response in
            
            if let data = response.data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print(json)
                        self.getCartProducts()
                    }
                } catch {
                    print(String(describing: error))
                    print(error.localizedDescription)
                }
            }
        }
        
    }
}
