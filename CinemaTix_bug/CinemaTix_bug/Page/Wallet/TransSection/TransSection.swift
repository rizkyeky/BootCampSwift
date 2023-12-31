//
//  TransSection.swift
//  CinemaTix
//
//  Created by Eky on 15/11/23.
//

import UIKit

class TransSection: UIView {

    @IBOutlet weak var table: UITableView!
    
    let walletViewModel = ContainerDI.shared.resolve(WalletViewModel.self)!
    
    var onRemoveItem: ((Int) -> Void)?
    
    var isLoading: Bool?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init with frame")
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("init with coder")
        configureView()
    }
    
    private func configureView() {
        let view = self.loadNib()
        view.frame = self.bounds
        view.clipsToBounds = true
        self.addSubview(view)
        
        table.delegate = self
        table.dataSource = self
        
        table.registerCellWithNib(TransCell.self)
        
        table.showsHorizontalScrollIndicator = false
        table.showsVerticalScrollIndicator = false
    }
}

extension TransSection: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let len = walletViewModel.getLenTrans()
        return len > 0 ? len : 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(TransCell.height+16)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(forIndexPath: indexPath) as TransCell
        
        if isLoading ?? false {
            cell.skeletonCornerRadius = 16
            cell.showAnimatedSkeleton()
        } else {
            cell.hideSkeleton()
        }
        if walletViewModel.getLenTrans() > 0 {
            let trans = walletViewModel.getTrans(indexPath.row)
            
            cell.label.text = "\(trans.label ?? "-")"
            cell.amount.text = "Rp\(NSNumber(value: trans.amount ?? 0).formatAsDecimalString())"
            
            if let type = trans.type {
                switch type {
                case .income:
                    cell.icon.image = SFIcon.up
                case .outcome:
                    cell.icon.image = SFIcon.down
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            table.beginUpdates()
            let id = walletViewModel.getTrans(indexPath.row).id
            walletViewModel.deleteTransBy(id: id ?? "")
            table.deleteRows(at: [indexPath], with: .left)
            table.endUpdates()
            onRemoveItem?(indexPath.row)
        }
    }
}
