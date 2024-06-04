//
//  HomeVC.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import UIKit
import RxSwift

class HomeVC: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    private let disposeBag = DisposeBag()
    @IBOutlet weak var collectionview: UICollectionView!
    
    let viewmodel = HomeVM()
    private var foods: [Food] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareView()
    }
    
    fileprivate func initDelegates() {
        viewmodel.delegate = self
        searchBar.delegate = self
        collectionview.delegate = self
        collectionview.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDelegates()
        viewmodel.getFoods()
        addSearchBarObserver()
    }
    
    fileprivate func prepareView() {
        self.navigationItem.hidesBackButton = true
        
        let backgroundImage = UIImageView(image: .splashBG)
        backgroundImage.contentMode = .scaleAspectFill
        collectionview.backgroundColor = .clear
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
    }
    
}

extension HomeVC: StoryboardInstantiable {}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell
        if let cell {
            
            cell.setup(food: self.foods[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foods.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 370, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let food = foods[indexPath.row]
        let vc = DetailVC.instantiateFromStoryboard()
        vc.food = food
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension HomeVC: HomeVMDelegate {
    func reloadFoods(foods: [Food]) {
        self.foods = foods
        DispatchQueue.main.async {
            self.collectionview.reloadData()
        }
    }
}

extension HomeVC: UISearchBarDelegate {
    func addSearchBarObserver() {
        searchBar.rx.text.orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance) // Değer değişimini bekletmek için kullanılır (örnekte 300 milisaniye)
            .distinctUntilChanged() // Ardışık aynı değerleri atlamak için kullanılır
            .subscribe(onNext: { [weak self] query in
                if query.isEmpty {
                    self?.viewmodel.backUpFiltereds()
                }
                else {
                    self?.viewmodel.filterFoods(foods: self?.foods ?? [], keyword: query)
                }
                
            })
            .disposed(by: disposeBag)
    }
    
    
}
