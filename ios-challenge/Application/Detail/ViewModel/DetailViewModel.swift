//
//  DetailViewModel.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 23.01.2022.
//

import UIKit

class DetailViewModel {
    
    private let movieId: String
    private let detailPageServiceProtocol: DetailPageServiceProtocol
    private var movieDetail: MovieDetail?
    let pageTitle: String
    var showLoadingHandler: ShowLoadingHandler?

    init(pageTitle: String, movieId: String, detailPageServiceProtocol: DetailPageServiceProtocol) {
        self.pageTitle = pageTitle
        self.movieId = movieId
        self.detailPageServiceProtocol = detailPageServiceProtocol
    }
    
    func fetchDetails(onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        showLoadingHandler?(true)
        detailPageServiceProtocol.fetchDetails(movieId: movieId) { [weak self] result in
            self?.showLoadingHandler?(false)
            switch result {
            case .success(let response):
                self?.movieDetail = response
                onSuccess()
            case .failure(let error):
                onError(error)
            }
        }
    }
}

// MARK: Computed Props
extension DetailViewModel {
    
    var title: String? {
        return movieDetail?.title
    }
    
    var description: NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 4
        
        let attributes = [
            NSAttributedString.Key.paragraphStyle: style,
            NSAttributedString.Key.foregroundColor: UIColor.textBlack,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular)
        ]
        return NSAttributedString(string: movieDetail?.overview ?? "", attributes: attributes)
    }
    
    var imageUrl: URL? {
        return movieDetail?.backdropUrl
    }
    
    var rating: NSAttributedString {
        let rateAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.textBlack,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .medium)
        ]
        let rateAttributedString = NSMutableAttributedString(
            string: "\(movieDetail?.voteAverage ?? 0)",
            attributes: rateAttributes
        )
        
        let maxRatesAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.darkGray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .medium)
        ]

        let maxRateAttributedString = NSMutableAttributedString(
            string: "/10",
            attributes: maxRatesAttributes
        )
        
        return rateAttributedString += maxRateAttributedString
    }
    
    var date: String? {
        return movieDetail?.uiFormattedDate
    }
    
    var imdbUrl: URL? {
        guard let detail = movieDetail else { return nil }
        return URL(string: "https://www.imdb.com/title/\(detail.imdbID)")
    }
}
