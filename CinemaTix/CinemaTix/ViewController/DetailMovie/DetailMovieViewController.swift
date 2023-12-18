//
//  DetailMovieViewController.swift
//  CinemaTix
//
//  Created by Eky on 18/12/23.
//

import UIKit

class DetailMovieViewController: BaseViewController {

    private let mainTable = {
        let table = UITableView()
        table.allowsSelection = false
        table.separatorStyle = .none
        table.sectionHeaderTopPadding = 0.0
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    private let viewModel = DetailMovieViewModel()
    
    private let movie: MovieModel
    private var movieDetail: MovieDetailModel?
    
    init(movie: MovieModel) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movieId = movie.id {
            viewModel.getDetailMovie(id: movieId) { detail in
                DispatchQueue.main.async {
                    self.movieDetail = detail
                }
            }
        }
        
        setupMainTable()
    }
    
    override func setupConstraints() {
        view.addSubview(mainTable)
        mainTable.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view)
        }
    }
    
    override func setupNavBar() {
        navigationItem.title = movie.title ?? "-"
    }
}

extension DetailMovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupMainTable() {
        
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.register(DetailMovieOverviewTableCell.self)
        mainTable.register(DetailMovieCastTableCell.self)
        mainTable.register(DetailMovieClipsTableCell.self)
        
        let imageView = UIImageView(frame: .init(x: 0, y: 0, width: view.bounds.width, height: 400))
        if let posterPath = movie.posterPath {
            let path = String(posterPath.dropFirst())
            imageView.loadFromUrl(url: TmdbApi.getImageURL(path, type: .w500), usePlaceholder: true)
        }
        mainTable.tableHeaderView = imageView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as DetailMovieOverviewTableCell
            cell.overview.text = movie.overview ?? "-"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as DetailMovieCastTableCell
            if let movieId = movie.id {
                viewModel.getCasts(id: movieId) { casts in
                    cell.updateCasts(casts)
                }
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as DetailMovieClipsTableCell
            if let movieId = movie.id {
                viewModel.getImages(id: movieId) { images in
                    cell.updateImages(images)
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let base = UIView()
        let label = UILabel()
        
        base.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.right.bottom.equalTo(base)
            make.left.equalTo(base.snp.left).offset(16)
        }
        
        switch section {
        case 0:
            label.text = "Overview"
            label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        case 1:
            label.text = "Cast"
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        case 2:
            label.text = "Clips"
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        default:
            break
        }
        
        return base
    }
}
    



