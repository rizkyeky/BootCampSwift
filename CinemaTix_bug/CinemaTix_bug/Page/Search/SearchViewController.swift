//
//  SearchViewController.swift
//  CinemaTix
//
//  Created by Eky on 08/11/23.
//

import UIKit
import Swinject
import RxSwift
import RxCocoa

class SearchViewController: BaseViewController {

    @IBOutlet weak var tableQueryList: UITableView!
    
    @IBOutlet weak var queryInputField: UITextField!
    
    let movieViewModel = ContainerDI.shared.resolve(MovieViewModel.self)!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navBar.isHidden = false
        navBar.title.text = "Search"
        navBar.title.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        navBar.title.textColor = .label
        navBar.backgroundColor = .systemBackground
        
        tableQueryList.delegate = self
        tableQueryList.dataSource = self
        tableQueryList.registerCellWithNib(QueryCellTableViewCell.self)
        
        tableQueryList.separatorStyle = .singleLine
        
        queryInputField.rx.text.orEmpty.bind(to: movieViewModel.querySearchText).disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        movieViewModel.getQuerySearch() {
            self.tableQueryList.reloadData()
        }
        queryInputField.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        movieViewModel.querySearchText.disposed(by: disposeBag)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = movieViewModel.resultsSearchMovies?.count {
            return count > 10 ? 10 : count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableQueryList.dequeueReusableCell(forIndexPath: indexPath) as QueryCellTableViewCell
        if let result = movieViewModel.resultsSearchMovies {
            cell.label.text = "\(result[indexPath.row].title ?? "-")"
            cell.onTap = {
                let movieVC = MovieDetailViewController(movie: result[indexPath.row])
                self.navigationController?.pushViewController(movieVC, animated: true)
            }
        }
        return cell
    }
}
