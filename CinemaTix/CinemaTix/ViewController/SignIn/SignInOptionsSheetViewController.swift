//
//  SignInOptionViewController.swift
//  CinemaTix
//
//  Created by Eky on 12/12/23.
//

import UIKit

class SignInOptionsSheetViewController: BaseViewController {
    
    let mainNavigationController: UINavigationController?
    
    init(navigationController mainNavigationController: UINavigationController?) {
        self.mainNavigationController = mainNavigationController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let appleButton: UIButton = {
        let button = FilledButton(title: "Sign In with Apple", icon: AppSVGIcon.apple.getImage())
        return button
    }()
    
    private let googleButton: UIButton = {
        let button = FilledButton(title: "Sign In with Google", isBold: true, icon: AppSVGIcon.google.getImage())
        return button
    }()
    
    private let emailButton: UIButton = {
        let button = FilledButton(title: "Sign In with Email", isBold: true, icon: AppSVGIcon.email.getImage())
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailButton.addAction(UIAction { _ in
            self.present(UINavigationController(rootViewController: SignInViewController()), animated: true, completion: nil)
        }, for: .touchUpInside)
    }
    
    override func setupNavBar() {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.backgroundColor = .secondarySystemBackground
            navigationBar.addBottomBorder(with: AppColor.separator, height: 1)
            
            let indicator = UIView(frame: .init(x: (navigationBar.bounds.width/2)-24, y: 8, width: 48, height: 4), color: AppColor.separator)
            indicator.makeCornerRadiusRounded()
            navigationBar.addSubview(indicator)
        }
    }
    
    override func setupConstraints() {
        view.addSubviews(appleButton, googleButton, emailButton)
        
        appleButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(32)
            make.width.equalTo(300)
            make.height.equalTo(48)
        }
        googleButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.appleButton.snp.bottom).offset(16)
            make.width.equalTo(300)
            make.height.equalTo(48)
        }
        emailButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.googleButton.snp.bottom).offset(16)
            make.width.equalTo(300)
            make.height.equalTo(48)
        }
        
    }
}
