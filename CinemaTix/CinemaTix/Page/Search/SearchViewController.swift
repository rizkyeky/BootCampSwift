//
//  SearchViewController.swift
//  CinemaTix
//
//  Created by Eky on 08/11/23.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableQueryList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Search"
        navigationItem.backButtonDisplayMode = .generic
        navigationItem.backButtonTitle = "Back"
        
        tableQueryList.separatorStyle = .none 
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableQueryList.dequeueReusableCell(forIndexPath: indexPath) as QueryCellTableViewCell
        cell.label.text = "Query list \(indexPath.row+1)"
        return cell
    }
    
    
}
