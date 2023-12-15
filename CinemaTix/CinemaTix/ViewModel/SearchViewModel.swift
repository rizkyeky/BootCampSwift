//
//  SearchViewModel.swift
//  CinemaTix
//
//  Created by Eky on 15/12/23.
//

import Foundation
import RxSwift

class SearchViewModel: BaseViewModel {
    
    private let movieService = MovieService()
    
    var resultsSearchMovies: [MovieModel]?
    
    let searchQuerySubject = PublishSubject<String>()
    
    func getMoviesByQuery(completion: @escaping () -> Void, onError: ((Error) -> Void)? = nil) {
        searchQuerySubject.subscribe() { text in
            self.movieService.getBySearch(query: text) { result in
                switch result {
                case .success(let models):
                    self.resultsSearchMovies = models
                    completion()
                case .failure(let error):
                    onError?(error)
                }
            }
        }.disposed(by: DisposeBag())
    }
}
