//
//  DetailVC.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import UIKit

class DetailVC: UIViewController {
    let viewmodel = DetailVM()
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var productCountLbl: UILabel!
    
    
    var food: Food?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let food = food else {
            return
        }
        
        imageView.setImage(with: food.yemekResimAdi.imageUrlGenerator)
        
        priceLbl.text = "\(food.yemekFiyat) TL"
        
        titleLbl.text = food.yemekAdi
        
        viewmodel.delegate = self
        
        viewmodel.getCartProducts(food: food)

    }
    
    @IBAction func minusCountTapped(_ sender: Any) {
        let count = Int(productCountLbl.text ?? "0") ?? 0
        let newCount = count - 1
        
        guard let food = food else {
            return
        }
        if newCount > 0 {
            viewmodel.updateFood(food: food, newCount: newCount)

        } else if newCount == 0 {
            viewmodel.deleteOrder()
        }

    }
    
    @IBAction func plusCountTapped(_ sender: Any) {
        let count = Int(productCountLbl.text ?? "0") ?? 0
        let newCount = count + 1
        
        productCountLbl.text = newCount.description
        
        guard let food = food else {
            return
        }
        if newCount == 1 {
            viewmodel.addWithNewValue(food: food, newCount: newCount)
        } else {
            viewmodel.updateFood(food: food, newCount: newCount)
        }
        
    }
}

extension DetailVC:StoryboardInstantiable {}

extension DetailVC: DetailVMDelegate {
    func updateCountLbl(count: String) {
        productCountLbl.text = count
    }
}
