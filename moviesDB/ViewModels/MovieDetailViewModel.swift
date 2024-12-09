//
//  MovieDetailViewModel.swift
//  moviesDB
//
//  Created by Alan Rodriguez on 09/12/24.
//

import SwiftUI

class MovieDetailViewModel: ObservableObject {
    @Published var genres: [Genre] = []
    var genreNames: [String] = []
    
    init() {
        fetchGenres()
    }
    
    func fetchGenres() {
        Task { @MainActor in
            let url = "https://api.themoviedb.org/3/genre/movie/list"
            let token = KeyConstants.APIKeys.token
            let result: Result<GenreResponse?, ServiceError> = await ServiceLayer.shared.getRequest(url: url, auth: token)
            switch result {
            case .success(let data):
                genres = data?.genres ?? []
            case .failure(let error):
                throw error
            }
        }
    }
    
    func getGenreNames(for ids: [Int]) -> String {
        for genre in genres where ids.contains(genre.id) {
            genreNames.append(genre.name)
        }
        
        return genreNames.joined(separator: ", ")
    }
}
