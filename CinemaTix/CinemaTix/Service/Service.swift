//
//  Model.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import Foundation
import Alamofire

class Service {
    
    func request<T: Codable>(url: URLRequestConvertible, expecting type: T.Type, completion: @escaping (Result<T, ErrorService>) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: type.self) { response in
                switch response.result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    let errorService = ErrorService(message: error.errorDescription)
                    debugPrint(error.errorDescription ?? "Null Error")
                    if let data = response.data {
                        let jsonString = String(data: data, encoding: .utf8)
                        debugPrint("Response JSON: \(jsonString ?? "")")
                    }
                    completion(.failure(errorService))
                }
            }
    }
}
