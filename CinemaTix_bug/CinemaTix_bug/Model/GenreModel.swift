//
//  GenreModel.swift
//  CinemaTix
//
//  Created by Eky on 14/11/23.
//

import Foundation

// MARK: - ResultGenre
struct ResultGenre: Codable {
    let genres: [Genre]?
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}
