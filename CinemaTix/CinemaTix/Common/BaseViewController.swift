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
        
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    fileprivate func setupNavBar() {
        view.addSubview(navBar)
        navBar.snp.makeConstraints { make in
            make.left.right.top.equalTo(0)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(NavBar.height)
        }
        navBar.isHidden = true
        navBar.onTapBackButton = {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
