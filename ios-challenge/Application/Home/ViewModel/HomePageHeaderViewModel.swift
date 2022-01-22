//
//  HomePageHeaderViewModel.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

class HomePageHeaderViewModel {
    
    private let movies: [Movie]
    private var cellViewModelList: [MovieCellViewModel] = []
    var shouldReloadData = true
    var cellCount: Int {
        return cellViewModelList.count
    }
    
    init(movies: [Movie]) {
        self.movies = movies
        setupCellViewModels()
    }
    
    private func setupCellViewModels() {
        var cellViewModelList: [MovieCellViewModel] = []
        cellViewModelList.reserveCapacity(movies.count)
        for (index, movie) in movies.enumerated() {
            cellViewModelList.append(
                MovieCellViewModel(
                    index: index,
                    movie: movie,
                    imageLoader: ImageLoader(imageUrl: movie.backdropUrl)
                )
            )
        }
        self.cellViewModelList = cellViewModelList
    }
    
    func cellViewModel(at index: Int) -> MovieCellViewModel {
        return cellViewModelList[index]
    }
}
