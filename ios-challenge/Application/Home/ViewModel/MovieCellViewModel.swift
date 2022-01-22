//
//  MovieCellViewModel.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

import UIKit

protocol MovieCellViewModelDelegate: AnyObject {
    var index: Int { get }
    func showLoadingIndicator(_ isLoading: Bool, for index: Int)
    func imageLoadCompleted(_ image: UIImage?, for index: Int)
}

class MovieCellViewModel {
    
    private let movie: Movie
    let index: Int
    var imageLoader: ImageLoaderProtocol
    weak var delegate: MovieCellViewModelDelegate?
    
    init(index: Int, movie: Movie, imageLoader: ImageLoaderProtocol) {
        self.index = index
        self.movie = movie
        self.imageLoader = imageLoader
    }
    
    func getImage(for index: Int) {
        imageLoader.showLoadingHandler = { [weak self] isLoading in
            guard self?.delegate?.index == self?.index else { return }
            self?.delegate?.showLoadingIndicator(isLoading, for: index)
        }
        imageLoader.getImage { [weak self] image in
            guard self?.delegate?.index == self?.index else { return }
            self?.delegate?.imageLoadCompleted(image, for: index)
        }
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
