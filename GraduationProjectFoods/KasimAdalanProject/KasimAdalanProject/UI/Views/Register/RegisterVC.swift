//
//  RegisterVC.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import UIKit
import RxSwift

class RegisterVC: UIViewController {
    
    @IBOutlet weak private var  usernameTxtField: UITextField!
    
    @IBOutlet weak private var  nameTxtField: UITextField!
    
    @IBOutlet weak private var  surnameTxtField: UITextField!
    
    @IBOutlet weak private var  phoneNumberTxtField: UITextField!
    
    @IBOutlet weak private var  passwordTxtField: UITextField!
    
    @IBOutlet weak private var  rePasswordTxtField: UITextField!
    
    @IBOutlet weak private var addressTxtField: UITextField!
    
    private let viewmodel = RegisterVM()
    
    private let disposeBag = DisposeBag()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDelegates()
        addObserversTextfield()
        
    }
    
    fileprivate func initDelegates() {
        viewmodel.delegate = self
        usernameTxtField.delegate = self
        nameTxtField.delegate = self
        surnameTxtField.delegate = self
        phoneNumberTxtField.delegate = self
        passwordTxtField.delegate = self
        rePasswordTxtField.delegate = self
        addressTxtField.delegate = self
    }
    
    fileprivate func prepareView() {
        self.navigationItem.hidesBackButton = false
        self.navigationItem.backButtonTitle = "Geri"
        
        let backgroundImage = UIImageView(image: .splashBG)
        backgroundImage.contentMode = .scaleAspectFill
        
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        viewmodel.getRegister()
    }
    
}

extension RegisterVC: StoryboardInstantiable {}
extension RegisterVC: UITextFieldDelegate {
    
    fileprivate func addObserversTextfield(){
        usernameTxtField.rx.text
            .orEmpty() 
            .subscribe(onNext: { [weak self] text in
                self?.usernameTxtField.text = text.removingNonTurkishCharacters()
                self?.viewmodel.updateUsername(userName: text.removingNonTurkishCharacters())
                
            })
            .disposed(by: disposeBag)        
        
        nameTxtField.rx.text
            .orEmpty() 
            .subscribe(onNext: { [weak self] text in
                self?.viewmodel.updateName(name: text)
            })
            .disposed(by: disposeBag)
        
        surnameTxtField.rx.text
            .orEmpty() 
            .subscribe(onNext: { [weak self] text in
                self?.viewmodel.updatesurname(surname: text)
            })
            .disposed(by: disposeBag)
        
        phoneNumberTxtField.rx.text
            .orEmpty() 
            .subscribe(onNext: { [weak self] text in
                self?.viewmodel.updatePhoneNumber(phoneNumber: text)
            })
            .disposed(by: disposeBag)
        
        passwordTxtField.rx.text
            .orEmpty() 
            .subscribe(onNext: { [weak self] text in
                self?.viewmodel.updatePassword(password: text)
            })
            .disposed(by: disposeBag)
        
        rePasswordTxtField.rx.text
            .orEmpty() 
            .subscribe(onNext: { [weak self] text in
                self?.viewmodel.updateRePassword(password: text)
            })
            .disposed(by: disposeBag)        
        
        addressTxtField.rx.text
            .orEmpty()
            .subscribe(onNext: { [weak self] text in
                self?.viewmodel.updateAddress(address: text)
            })
            .disposed(by: disposeBag)
        
    }
}

extension RegisterVC: RegisterVMDelegate {
    func finishRegister() {
        
        let title = "Başarılı"
        let message = "Kaydınız başarıyla tamamlandı"
        let action = AlertAction(title: "Tamam") {
            self.navigationController?.popViewController(animated: true)
        }
        
        AlertManager.showAlert(title: title, message: message,actions: [action])
        
    }
}
