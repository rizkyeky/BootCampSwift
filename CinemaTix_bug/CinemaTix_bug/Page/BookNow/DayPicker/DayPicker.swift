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
    
    private let bookViewModel = ContainerDI.shared.resolve(BookViewModel.self)
    
//    var indexSelected: Int?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        let view = self.loadNib()
        view.frame = self.bounds
        self.addSubview(view)
        
        bookViewModel?.init7Days()
        
        collection.delegate = self
        collection.dataSource = self
        collection.registerCellWithNib(DayPickerCell.self)
        collection.showsHorizontalScrollIndicator = false
        
        if let flowLayout = collection.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
    }
}

extension DayPicker: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookViewModel?.sevenDays.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell<DayPickerCell>(forIndexPath: indexPath) as DayPickerCell
        let i = indexPath.row
        
        if let theDay =  bookViewModel?.sevenDays[i] {
            
            cell.dateLabel.text = theDay.getDayOfWeek().formatted()
            if theDay.getDayOfWeek() == Date.now.getDayOfWeek() {
                cell.dayLabel.text = "Today"
            } else {
                cell.dayLabel.text = theDay.getDayName()
            }
            
            cell.onTap = {
                self.bookViewModel?.selectedDateRelay.accept(i)
            }
            
            bookViewModel?.selectedDateRelay.bind(onNext: { index in
                cell.didSelectedCell(index == i)
            }).disposed(by: bookViewModel?.disposeBag ?? DisposeBag())
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.indexSelected = indexPath.row
//    }
}
