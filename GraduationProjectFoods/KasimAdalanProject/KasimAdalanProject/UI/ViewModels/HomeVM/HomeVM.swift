//
//  HomeVM.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import Foundation
protocol HomeVMDelegate {
    func reloadFoods(foods: [Food])
}
class HomeVM {
    var delegate: HomeVMDelegate?
    private var backUpFoods: [Food] = []
    
    func getFoods(){
        NetworkManager.shared.request(with: .foods) { [weak self](response: Result<Foods, NetworkError>) in
            switch response {
            case .success(let model):
                self?.backUpFoods = model.yemekler
                self?.delegate?.reloadFoods(foods: model.yemekler)
            case .failure(let failure):
                AlertManager.showAlert(title: "Hata", message: "Bir sorun oluştu")
            }
        }
    }
    
    func filterFoods(foods: [Food], keyword:String) {
        let filtered = foods.filter { food in
            food.yemekAdi.contains(keyword)
        }
        self.delegate?.reloadFoods(foods: filtered)
    }
    
    func backUpFiltereds() {
        self.delegate?.reloadFoods(foods: self.backUpFoods)
    }
}
