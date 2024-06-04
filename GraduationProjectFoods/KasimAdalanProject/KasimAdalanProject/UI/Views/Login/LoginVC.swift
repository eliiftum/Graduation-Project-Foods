//
//  RegisterVCViewController.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import UIKit
import RxSwift
import RxCocoa
class LoginVC: UIViewController {
    let viewmodel = LoginVM()
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak private var usernameTxtField: UITextField!
    
    @IBOutlet weak private var passwordTxtField: UITextField!
    
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareView()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDelegates()
        addObserverTextFields()
    }
    
    fileprivate func prepareView() {
        self.navigationItem.hidesBackButton = true
        
        let backgroundImage = UIImageView(image: .splashBG)
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
    }
    
    fileprivate func initDelegates() {
        viewmodel.delegate = self
        usernameTxtField.delegate = self
        passwordTxtField.delegate = self
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        let vc = RegisterVC.instantiateFromStoryboard()
        self.navigationController?.pushViewController(vc,
                                                      animated: true)
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        viewmodel.getLogin()
    }
    
}

extension LoginVC: UITextFieldDelegate {
    private func addObserverTextFields(){
        passwordTxtField.rx.text
            .orEmpty() // orEmpty operatörünü burada kullanıyoruz
            .subscribe(onNext: { [weak self] password in
                self?.viewmodel.updatePassWord(password: password)
            })
            .disposed(by: disposeBag)
        
        
        usernameTxtField.rx.text
            .orEmpty() 
            .subscribe(onNext: { [weak self] username in
                self?.viewmodel.updateUsername(username: username)
            })
            .disposed(by: disposeBag)
    }
}
extension LoginVC: LoginVMDelegate {
    func routeToHomePage() {
        let vc = TabController.instantiateFromStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension LoginVC: StoryboardInstantiable {}
