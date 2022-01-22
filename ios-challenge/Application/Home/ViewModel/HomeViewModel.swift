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
                let firstFive = Array(movies.nowPlayingMovies.prefix(5))
                self.headerViewModel = HomePageHeaderViewModel(movies: firstFive)
                self.tableCellViewModelList = movies.upcomingMovies.map {
                    return MovieCellViewModel(
                        movie: $0,
                        imageLoader: ImageLoader(imageUrl: $0.backdropUrl)
                    )
                }
                onSuccess()
            case .failure(let errorMessage):
                onError(errorMessage)
            }
        }
    }
    
    func fetchNextPage() {
        
    }
    
    func cellViewModel(at index: Int) -> MovieCellViewModel {
        return tableCellViewModelList[index]
    }
}
