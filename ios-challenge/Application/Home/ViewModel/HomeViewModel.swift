//
//  HomeViewModel.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

typealias ShowLoadingHandler = (Bool) -> Void

class HomeViewModel {
    
    private let homePageService: HomePageServiceProcotol
    private(set) var headerViewModel: HomePageHeaderViewModel?
    private var tableCellViewModelList: [MovieCellViewModel] = []
    var showLoadingHandler: ShowLoadingHandler?
    
    var cellCount: Int {
        return tableCellViewModelList.count
    }
    
    init(homePageService: HomePageServiceProcotol) {
        self.homePageService = homePageService
    }
    
    func fetchHomePage(onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        showLoadingHandler?(true)
        homePageService.fetchHomePage { [weak self] homePageResult in
            guard let self = self else { return }
            self.showLoadingHandler?(false)
            switch homePageResult {
            case .success(let movies):
                self.setupCellViewModels(result: movies)
                onSuccess()
            case .failure(let errorMessage):
                onError(errorMessage)
            }
        }
    }
    
    private func setupCellViewModels(result: HomePageResult) {
        let firstFive = Array(result.nowPlayingMovies.prefix(5))
        self.headerViewModel = HomePageHeaderViewModel(movies: firstFive)

        let upcomingMovies = result.upcomingMovies
        var tableCellViewModelList: [MovieCellViewModel] = []
        tableCellViewModelList.reserveCapacity(upcomingMovies.count)
        for (index, movie) in upcomingMovies.enumerated() {
            tableCellViewModelList.append(
                MovieCellViewModel(
                    index: index,
                    movie: movie,
                    imageLoader: ImageLoader(imageUrl: movie.backdropUrl)
                )
            )
        }
        self.tableCellViewModelList = tableCellViewModelList
    }
    
    func fetchNextPage() {
        
    }
    
    func cellViewModel(at index: Int) -> MovieCellViewModel {
        return tableCellViewModelList[index]
    }
}
