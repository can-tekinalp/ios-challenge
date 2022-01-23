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
    
    private var viewModel: MovieCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
        activityIndicator.stopAnimating()
        viewModel?.cancelGetImage()
    }
    
    func configure(with viewModel: MovieCellViewModel?) {
        self.viewModel = viewModel
        titleLabel.text = viewModel?.title
        descriptionLabel.text = viewModel?.description
        dateLabel.text = viewModel?.date
        viewModel?.delegate = self
        viewModel?.getImage()
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
    
    func showLoadingIndicator(_ isLoading: Bool) {
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    func imageLoadCompleted(_ image: UIImage?) {
        movieImageView.image = image
    }
}
