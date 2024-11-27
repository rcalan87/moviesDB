//
//  moviesDBApp.swift
//  moviesDB
//
//  Created by Alan Rodriguez on 21/11/24.
//

import SwiftUI

@main
struct moviesDBApp: App {
    var body: some Scene {
        WindowGroup {
            MoviesListView()
                .environment(\.colorScheme, .dark)
        }
    }
}
