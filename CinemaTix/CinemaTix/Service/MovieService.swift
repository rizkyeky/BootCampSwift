//
//  MovieService.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import Foundation

class MovieService: Service {
    
    private let movieApi = MovieApi()
    
    func getDetail(id: Int, completion: @escaping (Result<MovieDetailModel, Error>) -> Void) -> Void {
        let url = movieApi.detailById(id)
        getData(url: url, expecting: MovieDetailModel.self, completion: completion)
    }
    
    func getPopular(completion: @escaping (Result<[MovieDetailModel]?, Error>) -> Void) -> Void {
        let url = movieApi.popular()
        getData(url: url, expecting: ResultTmDBList<MovieDetailModel>.self) { result in
            switch result {
            case .success(let model):
                let movies = model.results
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPlayingNow(completion: @escaping (Result<[MovieDetailModel]?, Error>) -> Void) -> Void {
        let url = movieApi.playingNow()
        getData(url: url, expecting: ResultTmDBList<MovieDetailModel>.self) { result in
            switch result {
            case .success(let model):
                let movies = model.results
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getUpComing(completion: @escaping (Result<[MovieDetailModel]?, Error>) -> Void) -> Void {
        let url = movieApi.upComing()
        getData(url: url, expecting: ResultTmDBList<MovieDetailModel>.self) { result in
            switch result {
            case .success(let model):
                let movies = model.results
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getTopRated(completion: @escaping (Result<[MovieDetailModel]?, Error>) -> Void) -> Void {
        let url = movieApi.topRated()
        getData(url: url, expecting: ResultTmDBList<MovieDetailModel>.self) { result in
            switch result {
            case .success(let model):
                let movies = model.results
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getBySearch(query: String, completion: @escaping (Result<[MovieDetailModel]?, Error>) -> Void) -> Void {
        let url = movieApi.searchByKeywords(query)
        getData(url: url, expecting: ResultTmDBList<MovieDetailModel>.self) { result in
            switch result {
            case .success(let model):
                let movies = model.results
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
