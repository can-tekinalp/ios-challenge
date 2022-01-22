//
//  HomePageService.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

import Foundation

struct HomePageResult {
    let nowPlayingMovies: [Movie]
    let upcomingMovies: [Movie]
}

protocol HomePageServiceProcotol {
    func fetchHomePage(completionHandler: @escaping (Result<HomePageResult, String>) -> Void)
}

class HomePageService: HomePageServiceProcotol {
    
    private let dispatchGroup = DispatchGroup()
    private var networkService: NetworkService
    private var nowPlayingMoviesResult: Result<GetMoviesResponse, NetworkServiceError>?
    private var upcomingMoviesResult: Result<GetMoviesResponse, NetworkServiceError>?
    
    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }
    
    func fetchHomePage(completionHandler: @escaping (Result<HomePageResult, String>) -> Void) {
        fetchNowPlayingMovies()
        fetchUpcomingMovies()
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            guard let nowPlayingMovies = self.nowPlayingMoviesResult?.success,
                  let upcomingMovies = self.upcomingMoviesResult?.success else {
                
                let errorMessage = [self.nowPlayingMoviesResult, self.upcomingMoviesResult]
                    .compactMap { $0?.failure }
                    .first?.message ?? unexpectedErrorMessage
                completionHandler(.failure(errorMessage))
                return
            }
            
            let homePageResult = HomePageResult(
                nowPlayingMovies: nowPlayingMovies.results,
                upcomingMovies: upcomingMovies.results
            )
            completionHandler(.success(homePageResult))
        }
    }
    
    private func fetchNowPlayingMovies() {
        dispatchGroup.enter()
        networkService.request(decodable: GetMoviesResponse.self, route: .nowPlaying, parameters: [:]) { [weak self] result in
            self?.nowPlayingMoviesResult = result
            self?.dispatchGroup.leave()
        }
    }
    
    private func fetchUpcomingMovies() {
        dispatchGroup.enter()
        networkService.request(decodable: GetMoviesResponse.self, route: .upcoming, parameters: [:]) { [weak self] result in
            self?.upcomingMoviesResult = result
            self?.dispatchGroup.leave()
        }
    }
}
