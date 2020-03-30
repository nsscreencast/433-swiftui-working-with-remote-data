//
//  MoviesModel.swift
//  SwiftUI-Movies
//
//  Created by Ben Scheirman on 3/23/20.
//  Copyright © 2020 NSScreencast. All rights reserved.
//

import SwiftUI
import Combine

class MoviesModel: ObservableObject {
    @Published
    private(set) var movies: [Movie] = []

    @Published
    var isLoading: Bool = false

    private let api = MoviesAPI()
    private var subscriptions: Set<AnyCancellable> = []

    func fetch() {
        isLoading = true
        api.popularMovies()
            .print("PopularMovies")
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveCompletion: { _ in
                self.isLoading = false
            })
            .assign(to: \.movies, on: self)
            .store(in: &subscriptions)
    }
}
