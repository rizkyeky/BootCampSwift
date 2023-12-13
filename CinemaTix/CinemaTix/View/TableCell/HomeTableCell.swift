//
//  HomeTableCell.swift
//  CinemaTix
//
//  Created by Eky on 13/12/23.
//

import UIKit
import SnapKit


class HomeTableCell: BaseTableCell {
    
    private let customSubview = UIView()
    
    override var isHighlighted: Bool {
        didSet {
            
            var transform: CGAffineTransform = .identity
            if isHighlighted {
                transform = .init(scaleX: 0.95, y: 0.95)
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1) {
                self.transform = transform
            }
        }
    }
    
    override func setup() {
        
        contentView.backgroundColor = .systemBlue
        contentView.addSubview(customSubview)
        
        customSubview.snp.makeConstraints { make in
            make.top.bottom.right.left.equalTo(contentView)
//            make.height.equalTo(200)
        }
    }
    
    func applyShadow() {
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 6
        layer.shadowOffset = .init(width: 0, height: 6)
        layer.shadowColor = UIColor.systemGray.cgColor
    }

}
