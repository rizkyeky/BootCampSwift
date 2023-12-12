//
//  PrimaryButton.swift
//  CinemaTix
//
//  Created by Eky on 12/12/23.
//

import UIKit

class FilledButton: UIButton {
    
    convenience init(title: String, icon: UIImage? = nil) {
        self.init(title: title, icon: icon, foregroundColor: .white, backgroundColor: AppColor.accent)
    }

}
