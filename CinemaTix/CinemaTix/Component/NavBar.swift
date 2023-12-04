//
//  NavBar.swift
//  CinemaTix
//
//  Created by Eky on 20/11/23.
//

import Foundation
import SnapKit

class NavBar: UIView {
    
    private(set) lazy var backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
    private(set) lazy var title = UILabel()
    private(set) lazy var blurBox = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
    private(set) lazy var contain = UIView()
    
    static let height = CGFloat(56)
    
    var isHasBlurBox = false {
        didSet {
            blurBox.isHidden = !isHasBlurBox
        }
    }
    
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
        
        blurBox.isHidden = !isHasBlurBox
        
        addSubview(blurBox)
        blurBox.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(self)
        }
        
        addSubview(contain)
        contain.snp.makeConstraints { make in
            make.height.equalTo(NavBar.height)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }
    
        contain.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.left.equalTo(self.contain).offset(16)
            make.centerY.equalToSuperview()
        }
        backButton.configuration = .plain()
        backButton.makeCornerRadiusRounded()
        backButton.setAnimateBounce()
        backButton.setImage(SFIcon.back?.resizeWith(size: CGSize(width: 20, height: 20)).reColor(.accent), for: .normal)
        backButton.setTitleColor(.accent, for: .normal)
        backButton.backgroundColor = .secondarySystemFill
        backButton.addAction(UIAction { _ in
            self.onTapBackButton?()
        }, for: .touchUpInside)
        
        contain.addSubview(title)
        title.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.centerY.centerX.equalTo(self.contain)
        }
        title.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        title.textColor = .white
        title.numberOfLines = 1
        title.textAlignment = .center
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView, point: CGFloat = 400.0) {
        let offsetY = scrollView.contentOffset.y
        let alpha = (offsetY - point) / NavBar.height
        title.textColor = .label.withAlphaComponent(alpha)
        
        if isHasBlurBox {
            blurBox.alpha = alpha
        } else {
            self.backgroundColor = .systemBackground.withAlphaComponent(alpha)
        }
    }
    
    func opacityBackgroundDidScroll(_ offsetY: CGFloat, point: CGFloat = 400.0, limit: CGFloat = 0.48) {
        let alpha = (offsetY - point) / NavBar.height
        if isHasBlurBox {
            blurBox.alpha = alpha
        }
        self.backgroundColor = self.backgroundColor?.withAlphaComponent(alpha > limit ? limit : alpha)
    }
}
