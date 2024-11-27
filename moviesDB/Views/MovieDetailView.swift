//
//  MovieDetailView.swift
//  moviesDB
//
//  Created by Alan Rodriguez on 21/11/24.
//

import SwiftUI

struct MovieDetailView: View {
    var movie: Movie
    @State var presentAlert = false
    
    var body: some View {
        VStack {
            if let posterPath = movie.posterPath {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { result in
                        result.image?
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: 350, alignment: .center)
                        .padding(.top, 20)
                }
            }
            
            VStack {
                Text(movie.title)
                    .font(.custom("MyFont", size: .init(20)))
                    .foregroundColor(._300)
                
                Text(movie.overview)
                    .font(.custom("MyFont", size: 14))
                    .padding(.horizontal, 20)
                    .foregroundColor(._500)
                
                Text(movie.releaseDate.getDate() ?? .now, format: .dateTime.day().month().year())
                    .font(.custom("MyFont", size: 12))
                    .foregroundColor(._600)
                
                Text("\(movie.voteAverage, specifier: "%.1f") / 10")
                    .font(.custom("MyFont", size: 16))
                    .foregroundColor(._400)
                
                HStack {
                    Spacer()

                    Button("Review") {
                        print("Review")
                        presentAlert.toggle()
                    }
                    .font(.custom("MyFont", size: 16))
                    .frame(width: 180, height: 50)
                    .background(Color._900,
                                in: RoundedRectangle(
                                    cornerRadius: 30,
                                    style: .continuous
                                ))
                    .foregroundColor(._400)
                    
                    Spacer()
                    
                    Button("Vote") {
                        print("Vote")
                        presentAlert.toggle()
                    }
                    .font(.custom("MyFont", size: 16))
                    .frame(width: 180, height: 50)
                    .background(Color._500,
                                in: RoundedRectangle(
                                    cornerRadius: 30,
                                    style: .continuous
                                ))
                    .foregroundColor(._800)
                    
                    Spacer()
                }
            }
            
            Spacer()
            
            if presentAlert {
                CustomAlertView(presentAlert: $presentAlert, alertType: .error(title: "Error", message: "No posting actions are available at this moment.")) {
                    withAnimation{
                        presentAlert.toggle()
                    }
                } rightButtonAction: {
                    withAnimation{
                        presentAlert.toggle()
                    }
                }
                .padding(.vertical, -((UIScreen.main.bounds.height / 2) + 50))
            }
        }
        .background(._800)
    }
}

#Preview {
    let overview = "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope."
    
    MovieDetailView(movie: Movie(id: 0, title: "The shawshank redemption", overview: overview, releaseDate: "", posterPath: "https://image.tmdb.org/t/p/w500/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg", backdropPath: "", voteAverage: 9.0))
}
