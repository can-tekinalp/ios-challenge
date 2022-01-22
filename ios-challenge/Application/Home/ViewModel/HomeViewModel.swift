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
        headerViewModel = HomePageHeaderViewModel(movies: firstFive)
        tableCellViewModelList = createTableCellViewModels(startingIndex: 0, movies: result.upcomingMovies)
    }
    
    private func createTableCellViewModels(startingIndex: Int, movies: [Movie]) -> [MovieCellViewModel] {
        var tableCellViewModelList: [MovieCellViewModel] = []
        tableCellViewModelList.reserveCapacity(movies.count)
        var index = startingIndex
        for movie in movies {
            tableCellViewModelList.append(
                MovieCellViewModel(
                    index: index,
                    movie: movie,
                    imageLoader: ImageLoader(imageUrl: movie.backdropUrl)
                )
            )
            index += 1
        }
        return tableCellViewModelList
    }
    
    func fetchNextPage(onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        homePageService.fetchNextPage { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let newCellViewModels = self.createTableCellViewModels(
                    startingIndex: self.tableCellViewModelList.last!.index + 1,
                    movies: response.results
                )
                self.tableCellViewModelList.append(contentsOf: newCellViewModels)
                onSuccess()
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func cellViewModel(at index: Int) -> MovieCellViewModel {
        return tableCellViewModelList[index]
    }
}
