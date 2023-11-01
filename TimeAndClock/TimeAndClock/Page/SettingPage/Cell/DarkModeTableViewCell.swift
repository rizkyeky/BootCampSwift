//
//  DarkModeTableViewCell.swift
//  TimeAndClock
//
//  Created by Eky on 01/11/23.
//

import UIKit

class DarkModeTableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var switchButton: UISwitch!
    
    var isDarkMode = false
    
    let defaults = UserDefaults.standard
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isDarkMode = defaults.bool(forKey: "darkmode")
        switchButton?.setOn(isDarkMode, animated: false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func onTapDarkMode(_ sender: Any) {
        turnOnOffDarkMode()
        isDarkMode.toggle()
        defaults.set(isDarkMode, forKey: "darkmode")
        switchButton?.setOn(isDarkMode, animated: true)
    }
    
    @IBAction func onChangedSwitchDarkMode(_ sender: Any) {
        turnOnOffDarkMode()
        isDarkMode.toggle()
        defaults.set(isDarkMode, forKey: "darkmode")
    }
    
    func turnOnOffDarkMode() {
        if #available(iOS 13.0, *) {
            if (!isDarkMode) {
                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
            } else {
                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
            }
        }
        
    }
    
}
