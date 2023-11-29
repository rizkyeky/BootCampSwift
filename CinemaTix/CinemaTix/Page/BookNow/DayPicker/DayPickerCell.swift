//
//  DayPickerCell.swift
//  CinemaTix
//
//  Created by Eky on 29/11/23.
//

import UIKit

class DayPickerCell: UICollectionViewCell {
    
    var onTap: (() -> Void)?

    @IBOutlet weak var box: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                UIView.animate(withDuration: 0.12, delay: 0.0, options: .curveEaseOut, animations: {
                    self.box.addBorderLine(width: 2.4, color: .accent)
                })
            } else {
                UIView.animate(withDuration: 0.12, delay: 0.0, options: .curveEaseOut, animations: {
                    self.box.layer.borderWidth = 0
                    self.box.layer.borderColor = nil
                })
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        box.backgroundColor = .secondarySystemFill
        box.makeCornerRadius(8)
    }
}

extension DayPickerCell: UIGestureRecognizerDelegate {
    
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
        resetAnimated()
        onTap?()
        isSelected.toggle()
    }
    
    internal override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetAnimated()
    }
    
    internal override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        shrinkAnimated()
    }
}
