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
    
    var loadingState: LoadingState = .done
    
    let movieService = MovieService()
    
    var playingNowMovies: [MovieDetailModel]?
    var popularMovies: [MovieDetailModel]?
    var topRatedMovies: [MovieDetailModel]?
    var upComingMovies: [MovieDetailModel]?
    
    var onCompleteGetPlayingNowMovies: [(() -> Void)?] = []
    func getPlayingNowMovies(completion: @escaping () -> Void) {
        loadingState = .start
        movieService.getPlayingNow() { result in
            switch result {
            case .success(let models):
                self.playingNowMovies = models
                self.loadingState = .done
                completion()
                for onComplete in self.onCompleteGetPlayingNowMovies {
                    onComplete?()
                }
            case .failure(_):
                self.loadingState = .done
            }
        }
    }
    
    var onCompleteGetPopularMovies: [(() -> Void)?] = []
    func getPopularMovies(completion: @escaping () -> Void) {
        loadingState = .start
        movieService.getPopular { result in
            switch result {
            case .success(let models):
                self.popularMovies = models
                self.loadingState = .done
                completion()
                for onComplete in self.onCompleteGetPopularMovies {
                    onComplete?()
                }
            case .failure(_):
                self.loadingState = .done
            }
        }
    }
    
    var onCompleteGetTopRatedMovies: [(() -> Void)?] = []
    func getTopRatedMovies(completion: @escaping () -> Void) {
        loadingState = .start
        movieService.getTopRated() { result in
            switch result {
            case .success(let models):
                self.topRatedMovies = models
                self.loadingState = .done
                completion()
                for onComplete in self.onCompleteGetTopRatedMovies {
                    onComplete?()
                }
            case .failure(_):
                self.loadingState = .done
            }
        }
    }
    
    var onCompleteGetUpComingMovies: [(() -> Void)?] = []
    func getUpComingMovies(completion: @escaping () -> Void) {
        loadingState = .start
        movieService.getUpComing { result in
            switch result {
            case .success(let models):
                self.upComingMovies = models
                self.loadingState = .done
                completion()
                for onComplete in self.onCompleteGetUpComingMovies {
                    onComplete?()
                }
            case .failure(_):
                self.loadingState = .done
            }
        }
    }

}
