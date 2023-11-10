//
//  Model.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import Foundation

// MARK: - ResultTmDB
struct BaseResultModel<T: Codable>: Codable {
    let dates: RangeDates?
    let page: Int?
    let results: [T]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - RangeDates
struct RangeDates: Codable {
    let maximum, minimum: String?
}
