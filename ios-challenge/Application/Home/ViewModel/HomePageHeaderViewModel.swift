//
//  HomePageHeaderViewModel.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

class HomePageHeaderViewModel {
    
    private var cellViewModelList: [MovieCellViewModel] = []
    var shouldReloadData = true
    var cellCount: Int {
        return cellViewModelList.count
    }
    
    init(movies: [Movie]) {
        self.cellViewModelList = movies.map {
            return MovieCellViewModel(
                movie: $0,
                imageLoader: ImageLoader(imageUrl: $0.originalBackdropUrl)
            )
        }
    }
    
    func cellViewModel(at index: Int) -> MovieCellViewModel {
        return cellViewModelList[index]
    }
}
