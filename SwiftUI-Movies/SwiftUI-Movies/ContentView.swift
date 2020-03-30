//
//  ContentView.swift
//  SwiftUI-Movies
//
//  Created by Ben Scheirman on 3/20/20.
//  Copyright © 2020 NSScreencast. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var moviesModel = MoviesModel()

    var body: some View {
        NavigationView {
            Group {
                List(self.moviesModel.movies, id: \.id) { movie in                    
                    Text(movie.title)
                }
            }
            .navigationBarTitle("Movies")
            .navigationBarItems(trailing: Group {
                Activity(isAnimating: $moviesModel.isLoading)
            })
            .onAppear {
                self.moviesModel.fetch()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
