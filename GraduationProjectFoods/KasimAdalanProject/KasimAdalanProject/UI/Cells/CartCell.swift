//
//  CartCell.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 3.06.2024.
//

import UIKit

class CartCell: UICollectionViewCell {
    var deleBtnClicked: (() -> Void)?
    @IBAction func deleteBtnTapped(_ sender: Any) {
        deleBtnClicked?()
    }
    
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(food:FoodsCart) {
        imageView.setImage(with: (food.yemekResimAdi ?? "").imageUrlGenerator)
        priceLbl.text =  "\(food.yemekFiyat ?? "0") TL"
        nameLbl.text = food.yemekAdi
        productCount.text = food.yemekSiparisAdet ?? "0"
    }
}
