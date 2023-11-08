//
//  MovieViewModel.swift
//  CinemaTix
//
//  Created by Eky on 08/11/23.
//

import Foundation
import RxSwift
import RxRelay

class MovieViewModel {
    
    let movieService = MovieService()
    
    func getPlayingNowMovies() {
        
    }
    
    private let dataRelay = BehaviorRelay<[MovieDetailModel]>(value: [])
        
    var data: Observable<[MovieDetailModel]> {
        return dataRelay.asObservable()
    }

    func fetchDataFromAPI() {
        // Make an API request and update the dataRelay with the fetched data.
        // Assuming `fetchedData` is an array of YourDataType.
//        let fetchedData: [MovieDetailModel] =
//        dataRelay.accept(fetchedData)
    }
}
