//
//  CartVC.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import UIKit

class CartVC: UIViewController {
    private var foods: [FoodsCart] = []
    private let viewmodel = CartVM()
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    @IBOutlet weak var totalCartLbl: UILabel!
    
    fileprivate func initDelegates() {
        viewmodel.delegate = self
        collectionview.delegate = self
        collectionview.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareView()
        initDelegates()
        viewmodel.getCartProducts()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    fileprivate func prepareView() {
        self.navigationItem.hidesBackButton = true
        
        let backgroundImage = UIImageView(image: .splashBG)
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
    }
}
extension CartVC: StoryboardInstantiable {}

extension CartVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foods.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCell", for: indexPath) as! CartCell
        
        cell.configure(food: foods[indexPath.row])
        
        cell.deleBtnClicked = {
            let food = self.foods[indexPath.row]
            
            self.viewmodel.orderDeleteSingle(sepetId: food.yemekSepetId ?? "",
                                             username: food.username ?? "elif.tum")
        }
        
        return cell
    }
    
    
}


extension CartVC: CartVMDelegate {
    func updateCartCollection(foods: [FoodsCart]) {
        self.foods = foods
        let toplam = foods.map({Int($0.yemekFiyat!)!}).reduce(0, +)
        
        DispatchQueue.main.async {
            self.collectionview.reloadData()
            self.totalCartLbl.text = "Toplam: \(toplam) TL"
        }
    }
    
}
