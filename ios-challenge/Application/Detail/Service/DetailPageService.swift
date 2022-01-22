//
//  DetailPageService.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 23.01.2022.
//

protocol DetailPageServiceProtocol: AnyObject {
    func fetchDetails(movieId: String, completionHandler: @escaping (Result<MovieDetail, String>) -> Void)
}

class DetailPageService: DetailPageServiceProtocol {
    
    private var networkService: NetworkService
    private var detailResult: Result<GetMoviesResponse, NetworkServiceError>?

    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }
    
    func fetchDetails(movieId: String, completionHandler: @escaping (Result<MovieDetail, String>) -> Void) {
        networkService.request(decodable: MovieDetail.self, route: .detail(movieId), parameters: [:]) { result in
            switch result {
            case .success(let response):
                completionHandler(.success(response))
            case .failure(let error):
                completionHandler(.failure(error.message))
            }
        }
    }

}
