//
//  NavBar.swift
//  CinemaTix
//
//  Created by Eky on 20/11/23.
//

import Foundation
import SnapKit

class NavBar: UIView {
    
    let backButton = UIButton(configuration: .plain())
    let title = UILabel()
    
    static let height = 120.0
    
    var onTapBackButton: (() -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.backgroundColor = .white
        backButton.makeCornerRadius(20)
        backButton.setAnimateBounce()
        backButton.addAction(UIAction { _ in
            self.onTapBackButton?()
        }, for: .touchUpInside)
        
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        addSubview(title)
        title.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        title.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        title.textColor = .white
    }
}
