//
//  MoviesModel.swift
//  SwiftUI-Movies
//
//  Created by Ben Scheirman on 3/20/20.
//  Copyright © 2020 NSScreencast. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class MoviesAPI {

    static var apiKey: String?
    let session: URLSession

    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }

    func popularMovies() -> AnyPublisher<[Movie], Error> {
        guard let apiKey = MoviesAPI.apiKey else { fatalError("Must set API key first") }
        var components = URLComponents(string: "https://api.themoviedb.org/3/discover/movie")!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "sort_by", value: "popularity.desc")
        ]
        let request = URLRequest(url: components.url!)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return session.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: MoviesResponse.self, decoder: decoder)
            .map { $0.results }
            .eraseToAnyPublisher()
    }
}

struct MoviesResponse: Decodable {
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let posterPath: String
}

extension Movie {
    var smallPosterURL: URL! {
        URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")!
    }
}
