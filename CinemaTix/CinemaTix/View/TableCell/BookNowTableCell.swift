//
//  BookNowTableCell.swift
//  CinemaTix
//
//  Created by Eky on 28/12/23.
//

import UIKit
import RxSwift
import RxCocoa

class BookNowDateTableCell: BaseTableCell {
    
    public var viewModel: BookNowViewModel?
    
    private let base = UIView()
    
    private let disposeBag = DisposeBag()
    
    private let collection = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = .init(width: 140, height: 100)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let coll = UICollectionView(frame: CGRect(x: 0, y: 0, width: 360, height: 160), collectionViewLayout: layout)
        coll.showsHorizontalScrollIndicator = false
        return coll
    }()
    
    override func setup() {
        
        collection.delegate = self
        collection.dataSource = self
        collection.register(cell: DateItemCell.self)
        
        base.backgroundColor = .lightGray
        contentView.addSubview(base)
        
        base.snp.makeConstraints { make in
            make.top.bottom.right.left.equalTo(contentView)
            make.height.equalTo(56)
        }
        
        base.addSubview(collection)
        collection.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(self.base)
        }
    }
}

extension BookNowDateTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.sevenDays.count ?? 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as DateItemCell
        setupCell(cell, indexPath.row)
        return cell
    }
    
    func setupCell(_ cell: DateItemCell, _ index: Int) {
        if let theDay =  viewModel?.sevenDays[index] {
            cell.dateLabel.text = theDay.getDayOfWeek().formatted()
            if theDay.getDayOfWeek() == Date.now.getDayOfWeek() {
                cell.dayLabel.text = "Today"
            } else {
                cell.dayLabel.text = theDay.getDayName()
            }
            
            cell.onTap = {
                self.viewModel?.selectedDateRelay.accept(index)
            }
            
            viewModel?.selectedDateRelay.bind(onNext: { _index in
                cell.didSelectedCell(_index == index)
            }).disposed(by: disposeBag)
        }
    }
}

class DateItemCell: BaseCollectionCell {
    
    private let base = UIView()
    
    public let dateLabel = UILabel()
    public let dayLabel = UILabel()
    
    override func setup() {
        base.backgroundColor = .secondarySystemFill
        base.makeCornerRadius(8)
        
        contentView.addSubview(base)
        base.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(100)
        }
        
    }
    
    func didSelectedCell(_ isSelected: Bool) {
        if isSelected {
            UIView.animate(withDuration: 0.12, delay: 0.0, options: .curveEaseOut, animations: {
                self.base.makeBorder(color: .accent)
            })
        } else {
            UIView.animate(withDuration: 0.12, delay: 0.0, options: .curveEaseOut, animations: {
                self.base.layer.borderWidth = 0
                self.base.layer.borderColor = nil
            })
            
        }
    }
}


class BookNowCinemaTableCell: BaseTableCell {
    
    public var viewModel: BookNowViewModel?
    
    private let base = UIView()
    
    override func setup() {
        
        base.backgroundColor = .darkGray
        contentView.addSubview(base)
        
        base.snp.makeConstraints { make in
            make.top.bottom.right.left.equalTo(contentView)
            make.height.equalTo(56)
        }
    }
}
