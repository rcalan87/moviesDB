//
//  MovieDetailView.swift
//  moviesDB
//
//  Created by Alan Rodriguez on 21/11/24.
//

import SwiftUI

struct MovieDetailView: View {
    struct Styles {
        static let titleSize = 20.0
        static let overviewSize = 14.0
        static let releaseDateSize = 12.0
        static let ratingSize = 16.0
        static let horizontalPadding = 20.0
        static let imageHeight = 350.0
        static let imageTopPadding = 20.0
        static let buttonHeight = 50.0
        static let buttonWidth = 180.0
        static let buttonFontSize = 16.0
        static let buttonCornerRadius = 30.0
        static let reviewButtonTitle = "Review"
        static let voteButtonTitle = "Vote"
        static let myFont = "MyFont"
        static let imageUrl = "https://image.tmdb.org/t/p/w500"
    }
    
    var movie: Movie
    @State var presentAlert = false
    
    var body: some View {
        VStack {
            if let posterPath = movie.posterPath {
                AsyncImage(url: URL(string: Styles.imageUrl + posterPath)) { result in
                        result.image?
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: Styles.imageHeight, alignment: .center)
                        .padding(.top, Styles.imageTopPadding)
                }
            }
            
            VStack {
                Text(movie.title)
                    .font(.custom(Styles.myFont, size: Styles.titleSize))
                    .foregroundColor(._300)
                
                Text(movie.overview)
                    .font(.custom(Styles.myFont, size: Styles.overviewSize))
                    .padding(.horizontal, Styles.horizontalPadding)
                    .foregroundColor(._500)
                
                Text(movie.releaseDate.getDate() ?? .now, format: .dateTime.day().month().year())
                    .font(.custom(Styles.myFont, size: Styles.releaseDateSize))
                    .foregroundColor(._600)
                
                Text("\(movie.voteAverage, specifier: "%.1f") / 10")
                    .font(.custom(Styles.myFont, size: Styles.ratingSize))
                    .foregroundColor(._400)
                
                HStack {
                    Spacer()

                    Button(Styles.reviewButtonTitle) {
                        presentAlert.toggle()
                    }
                    .font(.custom(Styles.myFont, size: Styles.buttonFontSize))
                    .frame(width: Styles.buttonWidth, height: Styles.buttonHeight)
                    .background(Color._900,
                                in: RoundedRectangle(
                                    cornerRadius: Styles.buttonCornerRadius,
                                    style: .continuous
                                ))
                    .foregroundColor(._400)
                    
                    Spacer()
                    
                    Button(Styles.voteButtonTitle) {
                        presentAlert.toggle()
                    }
                    .font(.custom(Styles.myFont, size: Styles.buttonFontSize))
                    .frame(width: Styles.buttonWidth, height: Styles.buttonHeight)
                    .background(Color._500,
                                in: RoundedRectangle(
                                    cornerRadius: Styles.buttonCornerRadius,
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
