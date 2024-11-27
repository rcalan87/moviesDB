//
//  Movie.swift
//  moviesDB
//
//  Created by Alan Rodriguez on 21/11/24.
//

import Foundation

struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
}

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
}
