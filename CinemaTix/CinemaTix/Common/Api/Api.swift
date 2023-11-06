//
//  Api.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import Foundation
import Alamofire

protocol Api {
    
    var baseURL: String { get }
    var key: String { get }
    var headers: HTTPHeaders { get }
    
}

class OmdbApi: Api {
    
    var baseURL: String = "http://www.omdbapi.com/"
    var key: String = "5324af12"
    var headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    func movieDetailByTitle(title: String, type: String = "movie", year: String?) -> Endpoint {
        var parameters = [
            "apiKey": key,
            "t": title,
            "type": type,
            "y": year,
        ]
        parameters = parameters.filter { $0.value != nil }
        return Endpoint(
            baseURL: baseURL,
            headers: headers,
            path: "",
            method: .get,
            query: parameters as Parameters
        )
    }
    
    func movieDetailBySearch(keywords: String, type: String = "movie", year: String?) -> Endpoint {
        var parameters = [
            "apiKey": key,
            "s": keywords,
            "type": type,
            "y": year,
        ]
        parameters = parameters.filter { $0.value != nil }
        return Endpoint(
            baseURL: baseURL,
            headers: headers,
            path: "",
            method: .get,
            query: parameters as Parameters
        )
    }
}

class TmdbApi: Api {
    
    var baseURL: String = "https://api.themoviedb.org/3/"
    var key: String = "f9786e6c408860d5243366d56f4565fb"
    var headers: HTTPHeaders = [
        "Content-Type": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmOTc4NmU2YzQwODg2MGQ1MjQzMzY2ZDU2ZjQ1NjVmYiIsInN1YiI6IjVmM2U3NmU0YzE3NWIyMDAzNjVjYWQyZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.m6-n_LC0tAyozYRn1U5dsKZ2SS1fJNjtrFpPU7AUg8g"
    ]
    
    internal func createEndpoint(path: String,
                                 method: HTTPMethod,
                                 query: Parameters? = nil,
                                 body: Parameters? = nil) -> Endpoint {
        return Endpoint(
            baseURL: baseURL,
            headers: headers,
            path: path,
            method: method,
            query: query,
            body: body
        )
    }
}
