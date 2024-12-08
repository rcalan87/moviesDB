//
//  MovieView.swift
//  moviesDB
//
//  Created by Alan Rodriguez on 21/11/24.
//

import SwiftUI

struct MovieView: View {
    struct Styles {
        static let titleSize = 18.0
        static let subtitleSize = 14.0
        static let horizontalPadding: CGFloat = 25.0
        static let width: CGFloat = 100.0
        static let height: CGFloat = 100.0
        static let myFont = "MyFont"
        static let imageUrl = "https://image.tmdb.org/t/p/w500"
    }
    
    let movie: Movie
    
    var body: some View {
        NavigationLink(destination: MovieDetailView(movie: movie)) {
            HStack {
                if let backdropPath = movie.backdropPath {
                    AsyncImage(url: URL(string: Styles.imageUrl + backdropPath)) { result in
                        result.image?
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                    }
                    .frame(width: Styles.width, height: Styles.height)
                    
                }
                
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.custom(Styles.myFont, size: Styles.titleSize))
                        .foregroundColor(._300)
                    
                    Text(movie.releaseDate.getDate() ?? .now, format: .dateTime.day().month().year())
                        .font(.custom(Styles.myFont, size: Styles.subtitleSize))
                        .foregroundColor(._600)
                }
            }
            .padding(.horizontal, -Styles.horizontalPadding)
        }
    }
}

#Preview {
    let overview = "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope."
    
    MovieView(movie: Movie(id: 0, title: "The shawshank redemption", overview: overview, releaseDate: "", posterPath: "https://image.tmdb.org/t/p/w500/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg", backdropPath: "", voteAverage: 9.0))
}
