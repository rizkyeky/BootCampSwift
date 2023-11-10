//
//  MovieDetailViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    var detail: MovieDetailModel?
    
    private var backDropImage: UIImageView {
        let im = UIImageView()
        return im
    }
    
    private var bookNowButton: UIButton {
        let btn = UIButton(configuration: .filled())
        btn.tintColor = .white
        btn.setTitle("Book Now", for: .normal)
        btn.setAnimateBounce()
        btn.addAction(UIAction() { _ in
            print("Book Now")
        }, for: .touchUpInside)
        return btn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = detail?.title ?? "Null"
        navigationItem.backButtonDisplayMode = .generic
        navigationItem.backButtonTitle = "Back"
        
//        if let backdropPath = detail?.backdropPath {
//            let path = String(backdropPath.dropFirst())
//            backDropImage.kf.setImage(with: TmdbApi.getImageURL(path), placeholder: UIImage(named: "imagenotfound"))
//            backDropImage.contentMode = .scaleAspectFill
//        }
        
        self.view.addSubview(backDropImage)
        backDropImage.snp.makeConstraints { make in
            make.top.equalTo(self.view)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(300)
        }
        
        backDropImage.addSubview(bookNowButton)
        bookNowButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.centerX.centerY.equalTo(self.bookNowButton)
//            make.left.equalToSuperview().offset(16)
//            make.right.equalToSuperview().offset(-16)
//            make.bottom.equalToSuperview().offset(-32)
        }
    }
}
