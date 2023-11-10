//
//  MovieDetailViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var backDropImage: UIImageView!
    
    @IBOutlet weak var overviewText: UILabel!
    
    
    var detail: MovieDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = detail?.title ?? "Null"
        navigationItem.backButtonTitle = "Back"
        navigationItem.backButtonDisplayMode = .minimal
        
        if let backdropPath = detail?.backdropPath {
            let path = String(backdropPath.dropFirst())
            backDropImage.kf.setImage(with: TmdbApi.getImageURL(path), placeholder: UIImage(named: "imagenotfound"))
            backDropImage.contentMode = .scaleAspectFill
        }
        
        if let desc = detail?.overview {
            overviewText.text = desc
        }
    }
}
