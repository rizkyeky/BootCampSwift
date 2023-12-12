//
//  TransCell.swift
//  CinemaTix
//
//  Created by Eky on 15/11/23.
//

import UIKit

class TransCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var amount: UILabel!
    
    var onTap: (() -> Void)?
    static let height = 50
    var trans: Transaction?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TransCell {
    
    private func shrinkAnimated() {
        UIView.animate(withDuration: 0.096, delay: 0.0, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
        })
    }
    
    private func resetAnimated() {
        UIView.animate(withDuration: 0.096, delay: 0.0, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform.identity
        })
    }
    
    internal override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        resetAnimated()
        onTap?()
    }
    
    internal override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        resetAnimated()
    }
    
    internal override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        shrinkAnimated()
    }
}
