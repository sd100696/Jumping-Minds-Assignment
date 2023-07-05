//
//  Movie.swift
//  Assignment
//
//  Created by Sudhanshu Dwivedi on 05/07/23.
//

import Foundation

// MARK: - MovieResult

struct MovieResult: Codable {
    let results: [Movie]?
    let totalResults, response: String?
    
    enum CodingKeys: String, CodingKey {
        case results = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - Movie
struct Movie: Codable {
    let title, year, imdbID: String?
    let type: TypeEnum?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum TypeEnum: String, Codable {
    case game = "game"
    case movie = "movie"
    case series = "series"
}
