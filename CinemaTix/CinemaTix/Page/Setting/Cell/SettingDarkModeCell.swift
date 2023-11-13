//
//  SettingDarkModeCell.swift
//  CinemaTix
//
//  Created by Eky on 13/11/23.
//

import UIKit

class SettingDarkModeCell: UITableViewCell {

    @IBOutlet weak var switchToggle: UISwitch!
    @IBOutlet weak var button: UIButton!
    
    let darkMode: DarkMode = ContainerDI.shared.resolve(DarkMode.self)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        button.contentHorizontalAlignment = .leading
        button.configuration?.cornerStyle = .fixed
        button.configuration?.buttonSize = .large
        button.configuration?.imagePlacement = .trailing
        button.tintColor = .label
        
        switchToggle.isOn = darkMode.isActive
        switchToggle.addAction(UIAction { _ in
            self.darkMode.toggle()
        }, for: .valueChanged)
        
        button.addAction(UIAction { _ in
            self.darkMode.toggle()
            self.switchToggle.setOn(self.darkMode.isActive, animated: true)
        }, for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
