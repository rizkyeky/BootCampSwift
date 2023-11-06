//
//  Model.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import Foundation
import Alamofire

class Service {
    
    func getData<T: Codable>(url: URLRequestConvertible, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: type.self) { response in
                switch response.result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
