//
//  TransSection.swift
//  CinemaTix
//
//  Created by Eky on 15/11/23.
//

import UIKit

class TransSection: UIView {

    @IBOutlet weak var table: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(TransCell.height+16)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(forIndexPath: indexPath) as TransCell
        cell.label.text = "Transaction \(indexPath.row)"
        return cell
    }
}
