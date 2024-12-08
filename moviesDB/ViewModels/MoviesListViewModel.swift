//
//  MoviesListViewModel.swift
//  moviesDB
//
//  Created by Alan Rodriguez on 25/11/24.
//

import SwiftUI

class MoviesListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var page: Int = 0
    
    init() {
        fetchMovies()
    }
    
    func fetchMovies(for pageNumber: Int? = nil) {
        Task { @MainActor in
            let url = "https://api.themoviedb.org/3/movie/top_rated"
            let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5YjgxMGM4MTAxZTE1OGEzYjI1YmU4MzQ1MGQ0MTA4MCIsIm5iZiI6MTczMjIyODYzNS4yNjczMDUxLCJzdWIiOiI2NzNmYTczMDhiNGU0YzJlZjZmNzZlNWMiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.Mn73-TwOFUE3KbLo9ELbNnQjpVL39Gt-GN7wsyySXCQ"
            let result: Result<MovieResponse?, ServiceError> = await ServiceLayer.shared.getRequest(url: url, page: (pageNumber ?? 0) + 1, auth: token)
            switch result {
            case .success(let data):
                guard let movieList = data else { throw ServiceError.genericError }
                movies.append(contentsOf: movieList.results)
                page = movieList.page
                print(movieList.results.map(\.posterPath))
            case .failure(let error):
                throw error
            }
        }
    }
}
