//
//  ExtUIViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    func openBottomSheet(to vc: UIViewController) {
        let signInNav = UINavigationController(rootViewController: vc)
        signInNav.modalPresentationStyle = .pageSheet
        if #available(iOS 15.0, *) {
            if let sheet = signInNav.sheetPresentationController {
                sheet.detents = [.large()]
            }
            present(signInNav, animated: true, completion: nil)
        }
    }
}
