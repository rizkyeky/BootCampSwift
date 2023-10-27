//
//  FormInputField.swift
//  Product1Minggu1
//
//  Created by Eky on 27/10/23.
//

import UIKit

@IBDesignable
class FormInputField: UIView {
    
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
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.separator.cgColor
        view.clipsToBounds = true
        self.addSubview(view)
    }
    
}
