//
//  MoviesListView.swift
//  moviesDB
//
//  Created by Alan Rodriguez on 21/11/24.
//

import SwiftUI

struct MoviesListView: View {
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
                
                Text("No more movies")
                    .onAppear {
                        viewModel.fetchMovies(for: viewModel.page + 1)
                    }
            }
            .padding(.horizontal, -30)
            .navigationTitle("Movies")
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
