//
//  MovieView.swift
//  moviesDB
//
//  Created by Alan Rodriguez on 21/11/24.
//

import SwiftUI

struct MovieView: View {
    let movie: Movie
    
    var body: some View {
        NavigationLink(destination: MovieDetailView(movie: movie)) {
            HStack {
                if let backdropPath = movie.backdropPath {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")) { result in
                        result.image?
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                    }
                    .frame(width: 100, height: 100)
                    
                }
                
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.custom("MyFont", size: 18))
                        .foregroundColor(._300)
                    
                    Text(movie.releaseDate.getDate() ?? .now, format: .dateTime.day().month().year())
                        .font(.custom("MyFont", size: 14))
                        .foregroundColor(._600)
                }
            }
            .padding(.horizontal, -25)
        }
    }
}

#Preview {
    let overview = "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope."
    
    MovieView(movie: Movie(id: 0, title: "The shawshank redemption", overview: overview, releaseDate: "", posterPath: "https://image.tmdb.org/t/p/w500/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg", backdropPath: "", voteAverage: 9.0))
}
