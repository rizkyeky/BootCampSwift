//
//  ShareViewController.swift
//  Product1Minggu1
//
//  Created by Eky on 26/10/23.
//

import UIKit

class ShareViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellWithNib(ShareCell.self)
    }
}


extension ShareViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath ) as ShareCell
        return cell
    }
}
