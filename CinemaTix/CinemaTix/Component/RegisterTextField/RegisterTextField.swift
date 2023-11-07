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
    
    var isObsecure = false
        
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
    }
    
    func activateObsecure() {
        isObsecure = true
        secureButton.isHidden = false
        textField.isSecureTextEntry = true
    }
    
    func didTapSecureButton(_ action: UIAction) {
        isHideInput.toggle()
        if isHideInput {
            secureButton.setImage(UIImage(named: "eye.slash.fill"), for: .normal)
            textField.isSecureTextEntry = true
        } else {
            secureButton.setImage(UIImage(named: "eye.fill"), for: .normal)
            textField.isSecureTextEntry = false
        }
    }
    
}
