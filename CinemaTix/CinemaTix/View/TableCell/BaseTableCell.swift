//
//  BaseTableCell.swift
//  CinemaTix
//
//  Created by Eky on 13/12/23.
//

import UIKit

class BaseTableCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    internal func setup() {
        
    }
}

