//
//  MovieApi.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import Foundation

class MovieApi: TmdbApi {
    
    var discover: Endpoint {
        get {
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
    }
    
    var genres: Endpoint {
        get {
            return createEndpoint(path: "genre/movie/list", method: .get)
        }
    }
    
    var playingNow: Endpoint {
        get {
            return createEndpoint(path: "movie/now_playing", method: .get, query: [
                "page": 1,
            ])
        }
    }
    
    var popular: Endpoint {
        get {
            return createEndpoint(path: "movie/popular", method: .get, query: [
                "page": 1,
            ])
        }
    }
    
    var topRated: Endpoint {
        get {
            return createEndpoint(path: "movie/top_rated", method: .get, query: [
                "page": 1,
            ])
        }
    }
    
    var upComing: Endpoint {
        get {
            return createEndpoint(path: "movie/upcoming", method: .get, query: [
                "page": 1,
            ])
        }
    }
    
    func detailById(_ id: Int) -> Endpoint {
        return createEndpoint(path: "movie/\(id)", method: .get)
    }
    
    func credit(_ id: Int) -> Endpoint {
        return createEndpoint(path: "movie/\(id)/credits", method: .get)
    }
    
    func images(_ id: Int) -> Endpoint {
        return createEndpoint(path: "movie/\(id)/images", method: .get)
    }
    
    func searchByKeywords(_ query: String) -> Endpoint {
        return createEndpoint(path: "search/movie", method: .get, query: [
            "query": query,
            "page": 1,
            "include_adult": false,
        ])
    }
}
