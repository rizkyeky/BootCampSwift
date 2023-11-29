//
//  BookViewModel.swift
//  CinemaTix
//
//  Created by Eky on 29/11/23.
//

import Foundation
import RxSwift
import RxCocoa

class BookViewModel: BaseViewModel {
    var movie: MovieModel?
    var movieDetail: MovieDetailModel?
    
    var selectedDateRelay = PublishRelay<Date>()
}
