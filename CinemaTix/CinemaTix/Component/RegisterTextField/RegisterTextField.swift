//
//  RegisterTextField.swift
//  CinemaTix
//
//  Created by Eky on 07/11/23.
//

import UIKit

class RegisterTextField: UIView {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var secureButton: UIButton!
    
    private var isObsecure = false
    private var isHideInput = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        let view = self.loadNib()
        view.frame = self.bounds
        view.clipsToBounds = true
        self.addSubview(view)
        
        secureButton.isHidden = true
        
        secureButton.setImage(UIImage(named: "eye.fill"), for: .normal)
        
        secureButton.setAnimateBounce()
        secureButton.addAction(UIAction(handler: didTapSecureButton), for: .touchUpInside)
        
        mainLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    func activateObsecure() {
        isObsecure = true
        isHideInput = true
        secureButton.isHidden = false
        textField.isSecureTextEntry = true
    }
    
    func didTapSecureButton(_ action: UIAction) {
        isHideInput.toggle()
        if isHideInput {
            secureButton.imageView?.image = UIImage(named: "eye.slash.fill")
            textField.isSecureTextEntry = true
        } else {
            secureButton.imageView?.image = UIImage(named: "eye.fill")
            textField.isSecureTextEntry = false
        }
    }
    
}
