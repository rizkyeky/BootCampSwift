//
//  NavBar.swift
//  CinemaTix
//
//  Created by Eky on 20/11/23.
//

import Foundation
import SnapKit

class NavBar: UIView {
    
    let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    let title = UILabel()
    
    static let height = CGFloat(64)
    
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
        
        let base = UIView()
        addSubview(base)
        base.snp.makeConstraints { make in
            make.height.equalTo(NavBar.height)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }
    
        base.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.left.equalTo(base).offset(16)
            make.centerY.equalToSuperview()
        }
        backButton.configuration = .plain()
        backButton.makeCornerRadiusRounded()
        backButton.setAnimateBounce()
        let image = SFIcon.backBlue
        backButton.setImage(image?.resizeWith(size: CGSize(width: 12, height: 12)), for: .normal)
        backButton.setTitleColor(.accent, for: .normal)
        backButton.backgroundColor = .white
        backButton.addAction(UIAction { _ in
            self.onTapBackButton?()
        }, for: .touchUpInside)
        
        base.addSubview(title)
        title.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.centerY.centerX.equalTo(base)
        }
        title.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        title.textColor = .white
        title.numberOfLines = 1
        title.textAlignment = .center
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let NAVBAR_COLORCHANGE_POINT = CGFloat(400)
        let offsetY = scrollView.contentOffset.y
//        if (offsetY > (NAVBAR_COLORCHANGE_POINT)) {
            let alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NavBar.height
            self.backgroundColor = .systemBackground.withAlphaComponent(alpha)
            title.textColor = .label.withAlphaComponent(alpha)
//        } else {
//            self.backgroundColor = .green
//            title.textColor = .label
//        }
    }
}
