//
//  MovieDetail.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 23.01.2022.
//

import Foundation

struct MovieDetail: Decodable {
    let id: Int
    let title: String
    let imdbID: String
    let overview: String
    let backdropPath: String?
    let releaseDate: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case imdbID = "imdb_id"
        case overview = "overview"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}

extension MovieDetail {
    
    var uiFormattedDate: String? {
        guard let date = apiDateFormatter.date(from: releaseDate) else { return nil }
        return uiDateFormatter.string(from: date)
    }
    
    var backdropUrl: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath)")
    }
}
