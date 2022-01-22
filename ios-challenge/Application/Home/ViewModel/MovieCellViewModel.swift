//
//  MovieCellViewModel.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

import UIKit

class MovieCellViewModel {
    
    private let movie: Movie
    var imageLoader: ImageLoaderProtocol
    
    init(movie: Movie, imageLoader: ImageLoaderProtocol) {
        self.movie = movie
        self.imageLoader = imageLoader
    }
    
    func getImage(showLoadingHandler: @escaping (Bool) -> Void, completionHandler: @escaping (UIImage?) -> Void) {
        imageLoader.showLoadingHandler = showLoadingHandler
        imageLoader.getImage(completionHandler: completionHandler)
    }
}

// MARK: Computed Props
extension MovieCellViewModel {
    
    var title: String {
        return movie.title
    }
    
    var description: String {
        return movie.overview
    }
    
    var date: String? {
        return movie.uiFormattedDate
    }
}
