//
//  SettingPageTableViewCell.swift
//  TimeAndClock
//
//  Created by Eky on 01/11/23.
//

import UIKit

class SettingPageTableViewCell: UITableViewCell {

    
    @IBOutlet weak var button: UIButton!
    
    var onTap: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func didTapButton(_ sender: Any) {
        onTap?()
    }
    
}
