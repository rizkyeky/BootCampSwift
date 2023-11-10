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
    
//    private let dataRelay = BehaviorRelay<[MovieDetailModel]>(value: [])
//    
//    let behavior = BehaviorSubject(value: 0)
//    let publish = PublishSubject<String>()
//        
//    var data: Observable<[MovieDetailModel]> {
//        return dataRelay.asObservable()
//    }
    
    var onCompleteGetPlayingNowMovies: [(() -> Void)?] = []
    func getPlayingNowMovies(completion: @escaping () -> Void ) {
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
            case .failure(let error):
                print(error.asAFError?.errorDescription)
                self.loadingState = .done
            }
        }
    }
}
