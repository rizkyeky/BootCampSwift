//
//  RegisterViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit
import RxSwift
import RxCocoa
import Swinject
import UIKitLivePreview
import SPAlert
import PKHUD

class RegisterViewController: BaseViewController {

    @IBOutlet weak var usernameTextField: RegisterTextField!
    @IBOutlet weak var emailTextField: RegisterTextField!
    @IBOutlet weak var passwordTextField: RegisterTextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var birthDatePicker: BrithDateView!
    
    var onTapRegisterButton: (() -> Void)?
    
    let authViewModel = ContainerDI.shared.resolve(AuthViewModel.self)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCancelButton()
        
        setupUsernameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        
        setupRegisterButton()
        
        birthDatePicker.onDateSelected = { day, month, year in
            self.authViewModel.birthDateTemp = Date.from(day: day, month: month, year: year) ?? Date()
        }
    }
    
    func setupCancelButton() {
//        navigationItem.title = "Register"
//        
//        let cancelButton = UIButton(configuration: .plain(), primaryAction: UIAction() { _ in
//            self.dismiss(animated: true)
//        })
//        cancelButton.setTitle("Cancel", for: .normal)
//        let cancelBarItem = UIBarButtonItem(customView: cancelButton)
//        
//        navigationItem.leftBarButtonItems = [cancelBarItem]
    }
    
    func setupUsernameTextField() {
        usernameTextField.mainLabel.text = "Username"
        usernameTextField.textField.placeholder = "Input username"
        
        usernameTextField.textField.rx.text
            .compactMap {$0}
            .filter { $0.isEmpty || $0.count > 4 }
//            .map { $0 + ".00"}
            .subscribe { [weak self] text in
                guard let self = self else {return}
                authViewModel.username = text
            
            }.disposed(by: disposeBag)
    }
    
    func setupEmailTextField() {
        emailTextField.mainLabel.text = "Email"
        emailTextField.textField.placeholder = "Input email"
        emailTextField.textField.keyboardType = .emailAddress
        
        emailTextField.textField.rx.text
            .compactMap {$0}
            .filter { $0.isEmpty || $0.count > 4 }
            .subscribe { [weak self] text in
                guard let self = self else {return}
                authViewModel.email = text
            }.disposed(by: disposeBag)
    }
    
    func setupPasswordTextField() {
        passwordTextField.mainLabel.text = "Password"
        passwordTextField.textField.placeholder = "Input password"
        passwordTextField.activateObsecure()
        
        passwordTextField.textField.rx.text
            .compactMap {$0}
            .filter { $0.isEmpty || $0.count > 4 }
            .subscribe { [weak self] text in
                guard let self = self else {return}
                authViewModel.password = text
        }.disposed(by: disposeBag)
    }
    
    func setupRegisterButton() {
        registerBtn.setAnimateBounce()
        let loading = Loading()
        registerBtn.rx.tap.subscribe { [weak self] _ in
            guard let self = self else {return}
            loading.show()
            authViewModel.registerWithFB {
                loading.hide()
                self.onTapRegisterButton?()
            } onError: { error in
                
            } onInvalidEmail: {
                loading.hide()
                self.showAlertOK(title: "Invalid Email", message: "Please input correct email")
            } onInvalidPassword: {
                loading.hide()
                self.showAlertOK(title: "Invalid Password", message: "Please input correct password")
            }
//            authViewModel.registerWith() { user in
//                self.onTapRegisterButton?()
//                HUD.flash(.success, delay: 1.0)
//                AlertKitAPI.present(
//                    title: "Success Register",
//                    icon: AlertIcon.done,
//                    style: .iOS17AppleMusic,
//                    haptic: .success
//                )
//            }onDone: {
//                
//            } onInvalidEmail: {
//                HUD.hide()
//                self.showAlertOK(title: "Invalid Email", message: "Please input correct email")
//            } onInvalidUsername: {
//                HUD.hide()
//                self.showAlertOK(title: "Invalid Username", message: "Please input correct username")
//            } onInvalidPassword: {
//                HUD.hide()
//                self.showAlertOK(title: "Invalid Password", message: "Please input correct password")
//            }
        }.disposed(by: disposeBag)
    }
}

class BrithDateView: UIView {
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    let days = Array(1...31)
    let years = Array(1900...2100)
    
    let pickerView = UIPickerView()
    
    var onDateSelected: ((Int, Int, Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(0)
            make.centerX.centerY.equalToSuperview()
        }
    }
}

extension BrithDateView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3 // Date, Month, Year
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: // Days
            return days.count
        case 1: // Months
            return months.count
        case 2: // Years
            return years.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: // Days
            return String(days[row])
        case 1: // Months
            return months[row]
        case 2: // Years
            return String(years[row])
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedDay = days[pickerView.selectedRow(inComponent: 0)]
        let selectedMonth = pickerView.selectedRow(inComponent: 1)
        let selectedYear = years[pickerView.selectedRow(inComponent: 2)]
        
        onDateSelected?(selectedDay, selectedMonth, selectedYear)
    }
}


#if DEBUG && canImport(SwiftUI)

import SwiftUI

@available(iOS 13.0, *)
struct RegisterViewController_Preview: PreviewProvider {
    static var previews: some View {
        RegisterViewController()
            .preview()
            .device(.iPhone11)
    }
}

#endif
