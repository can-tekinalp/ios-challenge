//
//  MovieCellViewModel.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

import UIKit

protocol MovieCellViewModelDelegate: AnyObject {
    func showLoadingIndicator(_ isLoading: Bool)
    func imageLoadCompleted(_ image: UIImage?)
}

class MovieCellViewModel {
    
    private var shouldCallDelegates = true
    let movie: Movie
    var imageLoader: ImageLoaderProtocol
    weak var delegate: MovieCellViewModelDelegate?
    
    init(movie: Movie, imageLoader: ImageLoaderProtocol) {
        self.movie = movie
        self.imageLoader = imageLoader
    }
    
    func getImage() {
        shouldCallDelegates = true
        imageLoader.showLoadingHandler = { [weak self] isLoading in
            guard self?.shouldCallDelegates == true else { return }
            self?.delegate?.showLoadingIndicator(isLoading)
        }
        imageLoader.getImage { [weak self] image in
            guard self?.shouldCallDelegates == true else { return }
            self?.delegate?.imageLoadCompleted(image)
        }
    }
    
    func cancelGetImage() {
        shouldCallDelegates = false
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
    
    var detailPageTitle: String {
        return movie.pageTitle ?? ""
    }
}
