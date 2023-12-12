//
//  MovieViewModel.swift
//  CinemaTix
//
//  Created by Eky on 08/11/23.
//

import Foundation
import RxSwift
import RxRelay

class MovieViewModel: BaseViewModel {
    
    let movieService = MovieService()
    
    var playingNowMovies: [MovieModel]?
    var popularMovies: [MovieModel]?
    var topRatedMovies: [MovieModel]?
    var upComingMovies: [MovieModel]?
    var resultsSearchMovies: [MovieModel]?
    var genres: [Genre]?
    
    let querySearchText = PublishSubject<String>()
    
    func getAllGenres(completion: (() -> Void)? = nil, onError: ((Error) -> Void)? = nil) {
        loadingState = .start
        movieService.getAllGenres() { result in
            switch result {
            case .success(let models):
                self.genres = models.genres
                self.loadingState = .done
                completion?()
            case .failure(let error):
                self.loadingState = .done
                onError?(error)
            }
            
        }
    }
    
    func getCredit(id: Int, completion: @escaping (([People]) -> Void), onError: ((Error) -> Void)? = nil) {
        loadingState = .start
        movieService.getCredit(id: id) { result in
            switch result {
            case .success(let models):
                self.loadingState = .done
                if let casts = models.cast {
                    completion(casts)
                }
            case .failure(let error):
                self.loadingState = .done
                onError?(error)
            }
        }
    }
    
    func getDetailMovie(id: Int, completion: @escaping ((MovieDetailModel) -> Void), onError: ((Error) -> Void)? = nil) {
        loadingState = .start
        movieService.getDetail(id: id) { result in
            switch result {
            case .success(let model):
                self.loadingState = .done
                completion(model)
            case .failure(let error):
                self.loadingState = .done
                onError?(error)
            }
        }
    }

    func getPlayingNowMovies(completion: @escaping () -> Void, onError: ((Error) -> Void)? = nil) {
        loadingState = .start
        movieService.getPlayingNow() { result in
            switch result {
            case .success(let models):
                self.playingNowMovies = models
                self.loadingState = .done
                completion()
            case .failure(let error):
                self.loadingState = .done
                onError?(error)
            }
        }
    }
    
    func getPopularMovies(completion: @escaping () -> Void, onError: ((Error) -> Void)? = nil) {
        loadingState = .start
        movieService.getPopular() { result in
            switch result {
            case .success(let models):
                self.popularMovies = models
                self.loadingState = .done
                completion()
            case .failure(let error):
                self.loadingState = .done
                onError?(error)
            }
        }
    }
    
    
    func getTopRatedMovies(completion: @escaping () -> Void, onError: ((Error) -> Void)? = nil) {
        loadingState = .start
        movieService.getTopRated() { result in
            switch result {
            case .success(let models):
                self.topRatedMovies = models
                self.loadingState = .done
                completion()
            case .failure(let error):
                self.loadingState = .done
                onError?(error)
            }
        }
    }
    
    func getUpComingMovies(completion: @escaping () -> Void, onError: ((Error) -> Void)? = nil) {
        loadingState = .start
        movieService.getUpComing() { result in
            switch result {
            case .success(let models):
                self.upComingMovies = models
                self.loadingState = .done
                completion()
            case .failure(let error):
                self.loadingState = .done
                onError?(error)
            }
        }
    }
    
    func getQuerySearch(completion: @escaping () -> Void, onError: ((Error) -> Void)? = nil) {
        querySearchText.subscribe() { text in
            self.loadingState = .start
            self.movieService.getBySearch(query: text) { result in
                switch result {
                case .success(let models):
                    self.resultsSearchMovies = models
                    self.loadingState = .done
                    completion()
                case .failure(let error):
                    self.loadingState = .done
                    onError?(error)
                }
            }
        }.disposed(by: disposeBag)
    }
}
