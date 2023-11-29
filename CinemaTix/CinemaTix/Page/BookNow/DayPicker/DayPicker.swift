//
//  DayPicker.swift
//  CinemaTix
//
//  Created by Eky on 29/11/23.
//

import UIKit
import RxSwift
import RxCocoa

class DayPicker: UIView {
    
    @IBOutlet weak var collection: UICollectionView!
    
    let bookViewModel = ContainerDI.shared.resolve(BookViewModel.self)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private var sevenDays: [Date] = []
    
    func setup() {
        let view = self.loadNib()
        view.frame = self.bounds
        self.addSubview(view)
        
        collection.delegate = self
        collection.dataSource = self
        collection.registerCellWithNib(DayPickerCell.self)
        collection.showsHorizontalScrollIndicator = false
        
        sevenDays.append(contentsOf: getDatesForThisWeek())
    }
}

extension DayPicker: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sevenDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell<DayPickerCell>(forIndexPath: indexPath) as DayPickerCell
        let i = indexPath.row
        
        let theDay =  sevenDays[i]
        if theDay.getDayOfWeek() == Date.now.getDayOfWeek() {
            cell.dayLabel.text = "Today"
        } else {
            cell.dayLabel.text = sevenDays[i].getDayName()
        }
        cell.dateLabel.text = sevenDays[i].getDayOfWeek().formatted()
        
        cell.onTap = {
            self.bookViewModel?.selectedDateRelay.accept(theDay)
        }
        
        self.bookViewModel?.selectedDateRelay.map { date in
            return cell.isSelected = date == theDay
        }.bind(to: cell.rx.isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}
