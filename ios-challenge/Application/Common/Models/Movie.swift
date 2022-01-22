//
//  Movie.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

import Foundation

fileprivate let apiDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = .current
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}()

fileprivate let uiDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = .current
    formatter.dateFormat = "dd-MM-yyyy"
    return formatter
}()

struct Movie: Decodable {
    let posterPath: String
    let adult: Bool
    let overview: String
    let releaseDate: String
    let genreIDS: [Int]
    let id: Int
    let originalTitle: String
    let originalLanguage: String
    let title: String
    let backdropPath: String?
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult = "adult"
        case overview = "overview"
        case releaseDate = "release_date"
        case genreIDS = "genre_ids"
        case id = "id"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title = "title"
        case backdropPath = "backdrop_path"
        case popularity = "popularity"
        case voteCount = "vote_count"
        case video = "video"
        case voteAverage = "vote_average"
    }
}

extension Movie {
    
    var uiFormattedDate: String? {
        guard let date = apiDateFormatter.date(from: releaseDate) else { return nil }
        return uiDateFormatter.string(from: date)
    }
    
    var backdropUrl: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath)")
    }
}
