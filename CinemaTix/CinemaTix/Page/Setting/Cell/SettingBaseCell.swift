//
//  SettingBaseCell.swift
//  CinemaTix
//
//  Created by Eky on 13/11/23.
//

import UIKit

class SettingBaseCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        button.makeCornerRadius(0)
        button.contentHorizontalAlignment = .fill
        button.configuration?.cornerStyle = .fixed
        button.configuration?.buttonSize = .large
        button.configuration?.imagePlacement = .trailing
        button.tintColor = .label
        
        if let iconImage = UIImage(systemName: "chevron.right") {
            button.setImage(iconImage, for: .normal)
            button.setPreferredSymbolConfiguration(.init(scale: .small), forImageIn: .normal)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
