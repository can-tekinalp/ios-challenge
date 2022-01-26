//
//  HomeViewModel.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

class HomeViewModel {
    
    private let homePageService: HomePageServiceProcotol
    private(set) var headerViewModel: HomePageHeaderViewModel?
    private var tableCellViewModelList: [MovieCellViewModel] = []
    var isLoadingHandler: IsLoadingHandler?
    
    var cellCount: Int {
        return tableCellViewModelList.count
    }
    
    init(homePageService: HomePageServiceProcotol) {
        self.homePageService = homePageService
    }
    
    func fetchHomePage(onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        isLoadingHandler?(true)
        homePageService.fetchHomePage { [weak self] homePageResult in
            guard let self = self else { return }
            self.isLoadingHandler?(false)
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
        tableCellViewModelList = result.upcomingMovies.map {
            return MovieCellViewModel(
                movie: $0,
                imageLoader: ImageLoader(imageUrl: $0.lowResBackdropUrl)
            )
        }
    }
    
    func fetchNextPage(onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        homePageService.fetchNextPage { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let newCellViewModels = response.results.map {
                    return MovieCellViewModel(
                        movie: $0,
                        imageLoader: ImageLoader(imageUrl: $0.lowResBackdropUrl)
                    )
                }
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
