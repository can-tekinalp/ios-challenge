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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    override func prepareForReuse() {
        movieImageView.image = nil
    }
    
    func configure(with viewModel: MovieCellViewModel?) {
        titleLabel.text = viewModel?.title
        descriptionLabel.text = viewModel?.description
        dateLabel.text = viewModel?.date
        viewModel?.getImage(
            showLoadingHandler: { [weak self] isLoading in
                isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
            }, completionHandler: { [weak self] image in
                self?.movieImageView.image = image
            }
        )
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
