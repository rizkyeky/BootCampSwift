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
    
    func showAlertOKCancel(title: String, message: String, onTapOK: (() -> Void)? = nil, onTapCancel: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            alert.dismiss(animated: true)
            onTapOK?()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            alert.dismiss(animated: true)
            onTapCancel?()
        }))
        present(alert, animated: true, completion: completion)
    }
    
    func showAlertOK(title: String, message: String, onTapOK: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            alert.dismiss(animated: true)
            onTapOK?()
        }))
        
        present(alert, animated: true, completion: completion)
    }

}
