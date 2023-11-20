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
    
    var onCompleteGetPlayingNowMovies: [(() -> Void)] = []
    var onCompleteGetUpComingMovies: [(() -> Void)] = []
    var onCompleteGetPopularMovies: [(() -> Void)] = []
    var onCompleteGetTopRatedMovies: [(() -> Void)] = []
    var onCompleteGetQuerySearch: [(() -> Void)] = []
    
    func getAllGenres(completion: (() -> Void)? = nil) {
        loadingState = .start
        movieService.getAllGenres() { result in
            switch result {
            case .success(let models):
                self.genres = models.genres
                self.loadingState = .done
            case .failure(_):
                self.loadingState = .done
            }
            completion?()
        }
    }
    
    func getCredit(id: Int, completion: @escaping (([People]?) -> Void)) {
        loadingState = .start
        movieService.getCredit(id: id) { result in
            switch result {
            case .success(let models):
                self.loadingState = .done
                completion(models.cast)
            case .failure(_):
                self.loadingState = .done
                completion(nil)
            }
        }
    }
    
    func getDetailMovie(id: Int, completion: @escaping ((MovieDetailModel) -> Void)) {
        loadingState = .start
        movieService.getDetail(id: id) { result in
            switch result {
            case .success(let model):
                self.loadingState = .done
                completion(model)
            case .failure(_):
                self.loadingState = .done
            }
        }
    }

    func getPlayingNowMovies(completion: @escaping () -> Void) {
        loadingState = .start
        movieService.getPlayingNow() { result in
            switch result {
            case .success(let models):
                self.playingNowMovies = models
                self.loadingState = .done
                completion()
                for onComplete in self.onCompleteGetPlayingNowMovies {
                    onComplete()
                }
            case .failure(_):
                self.loadingState = .done
            }
        }
    }
    
    
    func getPopularMovies(completion: @escaping () -> Void) {
        loadingState = .start
        movieService.getPopular() { result in
            switch result {
            case .success(let models):
                self.popularMovies = models
                self.loadingState = .done
                completion()
                for onComplete in self.onCompleteGetPopularMovies {
                    onComplete()
                }
            case .failure(_):
                self.loadingState = .done
            }
        }
    }
    
    
    func getTopRatedMovies(completion: @escaping () -> Void) {
        loadingState = .start
        movieService.getTopRated() { result in
            switch result {
            case .success(let models):
                self.topRatedMovies = models
                self.loadingState = .done
                completion()
                for onComplete in self.onCompleteGetTopRatedMovies {
                    onComplete()
                }
            case .failure(_):
                self.loadingState = .done
            }
        }
    }
    
    func getUpComingMovies(completion: @escaping () -> Void) {
        loadingState = .start
        movieService.getUpComing() { result in
            switch result {
            case .success(let models):
                self.upComingMovies = models
                self.loadingState = .done
                completion()
                for onComplete in self.onCompleteGetUpComingMovies {
                    onComplete()
                }
            case .failure(_):
                self.loadingState = .done
            }
        }
    }
    
    func getQuerySearch(completion: @escaping () -> Void) {
        querySearchText.subscribe() { text in
            self.loadingState = .start
            self.movieService.getBySearch(query: text) { result in
                switch result {
                case .success(let models):
                    self.resultsSearchMovies = models
                    self.loadingState = .done
                    completion()
                    for onComplete in self.onCompleteGetQuerySearch {
                        onComplete()
                    }
                case .failure(_):
                    self.loadingState = .done
                }
            }
        }.disposed(by: disposeBag)
    }
}
