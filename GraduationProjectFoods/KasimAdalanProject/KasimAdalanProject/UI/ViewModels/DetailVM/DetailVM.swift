//
//  DetailVM.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import Foundation
import Alamofire

protocol DetailVMDelegate {
    func updateCountLbl(count: String)
}

class DetailVM {
    var delegate: DetailVMDelegate?
    private var cartFood: FoodsCart?
    
    func getCartProducts(food: Food){
        let params = ["kullanici_adi": CacheManager.shared.getUsername() ?? "elif_tum"]
        NetworkManager.shared.requestAF(with: .cart, params: params) {[weak self](response: Result<CartFoodsResponse, NetworkError>) in
            
            switch response {
            case .success(let model):
                if let yemekler = model.yemekler {
                    self?.filterFoodCount(foodYemekAdi: food.yemekAdi, cartResponse: yemekler)
                }
              
            case .failure(let failure):
                _ = failure
            }
        }
    }
    
    func filterFoodCount(foodYemekAdi: String, cartResponse: [FoodsCart]) {

        let filter = cartResponse.filter { foodsCart in
            foodsCart.yemekAdi == foodYemekAdi
        }
        self.cartFood = filter.first
        
        let count = filter.first?.yemekSiparisAdet ?? "0"
        
        self.delegate?.updateCountLbl(count: count)
    }
    
    func updateFood(food: Food, newCount: Int){
        let foodCartId = Int(food.yemekID) ?? 0
        let username = CacheManager.shared.getUsername() ?? "elif.tum"
        
        let params: Parameters = ["sepet_yemek_id": cartFood?.yemekSepetId ?? "", "kullanici_adi": cartFood?.username ??  username]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 , execute: {
                            self.addWithNewValue(food: food,
                                                 newCount: newCount)
                        })
                    }
                } catch {
                    print(String(describing: error))
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func addWithNewValue(food:Food,newCount: Int){
        let username = CacheManager.shared.getUsername() ?? "elif_tum"
        let params: Parameters = ["yemek_adi": food.yemekAdi,
                                  "yemek_resim_adi": food.yemekResimAdi,
                                  "yemek_fiyat": food.yemekFiyat,
                                  "yemek_siparis_adet": String(newCount),
                                  "kullanici_adi": username]
        print(params)
        NetworkManager.shared.requestAF(with: .addFoodToCart, params: params)  { [weak self](response: Result<CartFoodsResponse, NetworkError>) in
            switch response {
            case .success(let success):
                if let yemekler = success.yemekler {
                    self?.filterFoodCount(foodYemekAdi: self?.cartFood?.yemekAdi ?? "", cartResponse: yemekler)
                }
            case .failure(let failure):
                AlertManager.showAlert(title: "Hata", message: "Bir şeyler ters gitti")
            }
        }
    }
    
    
    
    func deleteOrder(){
        
        let params: Parameters = ["sepet_yemek_id": self.cartFood?.yemekSepetId, "kullanici_adi": self.cartFood?.username]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print(json)
                    }
                } catch {
                    print(String(describing: error))
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
