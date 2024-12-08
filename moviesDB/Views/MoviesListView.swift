//
//  MoviesListView.swift
//  moviesDB
//
//  Created by Alan Rodriguez on 21/11/24.
//

import SwiftUI

struct MoviesListView: View {
    struct Styles {
        static let horizontalPadding: CGFloat = 30.0
        static let navigationBarTitle = "Movies"
        static let errorText = "No more movies"
    }
    
    @StateObject var viewModel = MoviesListViewModel()
    
    var body: some View {
        NavigationView(content: {
            List {
                ForEach(viewModel.movies, id: \.id) { movie in
                    MovieView(movie: movie)
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .foregroundColor(.white)
                .padding(.horizontal)
                
                Text(Styles.errorText)
                    .onAppear {
                        viewModel.fetchMovies(for: viewModel.page)
                    }
            }
            .padding(.horizontal, -Styles.horizontalPadding)
            .navigationTitle(Styles.navigationBarTitle)
            .scrollContentBackground(.hidden)
            .background(._800)
            .preferredColorScheme(.dark)
        })
        .accentColor(._300)
    }
}

#Preview {
    MoviesListView()
}
