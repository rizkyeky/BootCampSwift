//
//  MovieApi.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import Foundation

class MovieApi: TmdbApi {
    
    func discover() -> Endpoint {
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        return createEndpoint(
            path: "discover/movie", method: .get, query: [
                "page": 1,
                "primary_release_year": year
            ]
        )
    }
    
    func genres() -> Endpoint {
        return createEndpoint(path: "genre/movie/list", method: .get)
    }
    
    func playingNow() -> Endpoint {
        return createEndpoint(path: "movie/now_playing", method: .get, query: [
            "page": 1,
        ])
    }
    
    func popular() -> Endpoint {
        return createEndpoint(path: "movie/popular", method: .get, query: [
            "page": 1,
        ])
    }
    
    func topRated() -> Endpoint {
        return createEndpoint(path: "movie/top_rated", method: .get, query: [
            "page": 1,
        ])
    }
    
    func upComing() -> Endpoint {
        return createEndpoint(path: "movie/upcoming", method: .get, query: [
            "page": 1,
        ])
    }
    
    func detailById(_ id: Int) -> Endpoint {
        return createEndpoint(path: "movie/\(id)", method: .get)
    }
    
    func searchByKeywords(_ query: String) -> Endpoint {
        return createEndpoint(path: "search/movie", method: .get, query: [
            "query": query,
            "page": 1,
        ])
    }
}
