//
//  ProductCell.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet private var foodName: UILabel!
    
    @IBOutlet private var foodPrice: UILabel!
    @IBOutlet private var foodImageView: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup(food: Food) {
        DispatchQueue.main.async {
            self.foodName.text = food.yemekAdi
            self.foodPrice.text = "\(food.yemekFiyat) TL"
            self.foodImageView.setImage(with: food.yemekResimAdi.imageUrlGenerator)
        }
    }
}
