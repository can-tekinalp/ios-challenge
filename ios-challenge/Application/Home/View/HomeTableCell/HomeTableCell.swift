//
//  HomeTableCell.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

import UIKit

final class HomeTableCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    var index: Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
        activityIndicator.stopAnimating()
    }
    
    func configure(with viewModel: MovieCellViewModel?, index: Int) {
        self.index = index
        titleLabel.text = viewModel?.title
        descriptionLabel.text = viewModel?.description
        dateLabel.text = viewModel?.date
        viewModel?.delegate = self
        viewModel?.getImage(for: index)
    }
    
    func imageLoadCompleted() {
        
    }
}

// MARK: Setup
extension HomeTableCell {
    
    private func setup() {
        stackView.setCustomSpacing(16, after: descriptionLabel)
        movieImageView.layer.cornerRadius = 10
        titleLabel.textColor = .textBlack
        descriptionLabel.textColor = .textGray
        dateLabel.textColor = .textGray
        lineView.backgroundColor = .lightGray
    }
}

extension HomeTableCell: MovieCellViewModelDelegate {
    
    func showLoadingIndicator(_ isLoading: Bool, for index: Int) {
        guard self.index == index else { return }
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    func imageLoadCompleted(_ image: UIImage?, for index: Int) {
        guard self.index == index else { return }
        movieImageView.image = image
    }
}

//viewModel?.getImage(
//    showLoadingHandler: { [weak self] isLoading, imageForIndex in
//        guard self?.index == imageForIndex else { return }
//        isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
//    }, completionHandler: { [weak self] image, imageForIndex in
//        guard self?.index == imageForIndex else {
//            print()
//            return
//        }
//        self?.movieImageView.image = image
//    }
//)
