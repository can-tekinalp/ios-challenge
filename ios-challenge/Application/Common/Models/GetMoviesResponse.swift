//
//  GetMoviesResponse.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

struct GetMoviesResponse: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
