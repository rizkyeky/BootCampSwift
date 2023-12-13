//
//  HomeViewController.swift
//  CinemaTix
//
//  Created by Eky on 13/12/23.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private let mainTable = UITableView()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addAction(UIAction() { _ in
            self.refreshControl.endRefreshing()
        }, for: .primaryActionTriggered)
                
        setupMainTable()
    }
    
    override func setupNavBar() {
        if let navBar = navigationController?.navigationBar {
            navBar.transform = CGAffineTransform(translationX: 0, y: -100)
        }
    }
    
    override func setupConstraints() {
        view.addSubview(mainTable)
        mainTable.addSubview(refreshControl)
        mainTable.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.top.equalToSuperview().inset(-100)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupMainTable() {
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.allowsSelection = false
        mainTable.separatorStyle = .none
        
        mainTable.tableHeaderView = HomeCarousel(size: CGSize(width: view.bounds.width, height: 480))
        mainTable.showsVerticalScrollIndicator = false
        mainTable.register(HomeTableCell.self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return [
            360,
            160,
            160,
        ][indexPath.section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let base = UIView()
        let tile = UIStackView(frame: .init(x: 0, y: 0, width: view.bounds.width, height: 52))
        let label = UILabel()
        let forwardBtn = TextButton(withTitle: "", icon: AppIcon.forward, size: CGSize(width: 40, height: 40), iconSize: CGSize(width: 20, height: 20))
    
        tile.axis = .horizontal
        tile.distribution = .fillProportionally
        tile.alignment = .center
        tile.addArrangedSubview(label)
        tile.addArrangedSubview(forwardBtn)
        
        forwardBtn.snp.makeConstraints { make in
            make.height.width.equalTo(40)
        }
        
        base.backgroundColor = .secondarySystemBackground
        base.addSubview(tile)
        tile.snp.makeConstraints { make in
            make.top.bottom.equalTo(base)
            make.left.equalTo(base).offset(16)
            make.right.equalTo(base).inset(16)
        }
        
        switch section {
        case 0:
            label.text = LanguageStrings.playingNow.localized
            label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
            forwardBtn.isHidden = true
        case 1:
            label.text = LanguageStrings.recommendedForYou.localized
            label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        case 2:
            label.text = LanguageStrings.upcoming.localized
            label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        default:
            break
        }
        
        return base
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as HomeTableCell
        return cell
    }
}

class HomeCarousel: UIView {
    
    private let pageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .systemBlue.withAlphaComponent(0.2)
        pageControl.currentPageIndicatorTintColor = .white
        return pageControl
    }()
    
    private let scrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = .systemGray
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    init(size: CGSize) {
        
        super.init(frame: .init(origin: CGPoint(x: 0, y: 0), size: size))
        
        scrollView.delegate = self
        
        pageControl.numberOfPages = 3
        
        addSubviews(scrollView, pageControl)
        scrollView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(480)
        }
        pageControl.snp.makeConstraints { make in
            make.centerX.equalTo(self.scrollView)
            make.height.equalTo(40)
            make.width.equalTo(300)
            make.bottom.equalTo(self.scrollView.snp.bottom)
        }
        
        configureScrolIView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureScrolIView() {
        scrollView.contentSize = CGSize(width: frame.width*CGFloat(3), height: scrollView.frame.height)
        scrollView.isPagingEnabled = true
        for x in 0..<3 {
            let child = UIView(frame: CGRect(x: CGFloat(x) * frame.width, y: 0, width: frame.width, height: scrollView.frame.height))
            child.backgroundColor = [
                UIColor.systemRed,
                UIColor.systemBlue,
                UIColor.systemGreen,
            ][x]
            scrollView.addSubview(child)
//            child.snp.makeConstraints { make in
//                make.top.left.right.bottom.equalTo(scrollView)
//            }
        }
    }
}

extension HomeCarousel: UIScrollViewDelegate {
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
//        pageControl.currentPage = Int(pageIndex)
//    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
