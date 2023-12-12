//
//  WelcomeViewController.swift
//  CinemaTix
//
//  Created by Eky on 12/12/23.
//

import UIKit

class WelcomeViewController: BaseViewController {
    
    private let logoIconImage = {
        let image = UIImageView(image: UIImage(named: "Icon"))
        image.frame = .init(x: 0, y: 0, width: 160, height: 160)
        return image
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton(title: "SIGN IN", isBold: true, foregroundColor: .white, backgroundColor: AppColor.accent)
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(title: "REGISTER", isBold: true, foregroundColor: .white, backgroundColor: AppColor.accent?.withAlphaComponent(0.6))
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.addAction(UIAction { _ in
            self.showBottomSheet(to: SignInOptionsSheetViewController(navigationController: self.navigationController), level: [.medium()])
        }, for: .touchUpInside)
    }
    
    override func setupConstraints() {
        
        view.addSubviews(logoIconImage, signInButton, registerButton)
        
        logoIconImage.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(64)
            make.height.width.equalTo(160)
        }
        
        signInButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.logoIconImage.snp.bottom).offset(32)
            make.width.equalTo(300)
            make.height.equalTo(48)
        }
        
        registerButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.signInButton.snp.bottom).offset(16)
            make.width.equalTo(300)
            make.height.equalTo(48)
        }
    }
}
