//
//  BaseViewController.swift
//  CinemaTix
//
//  Created by Eky on 07/11/23.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    internal let disposeBag = DisposeBag()
    lazy var navBar = NavBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    fileprivate func setupNavBar() {
        view.addSubview(navBar)
        navBar.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(NavBar.height)
        }
        
        navBar.isHidden = true
        navBar.onTapBackButton = {
            if self.navigationController?.children.isEmpty == false {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.dismiss(animated: true)
            }
        }
    }
}
