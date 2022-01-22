//
//  HomeHeaderCollectionCell.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

import UIKit

final class HomeHeaderCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with viewModel: MovieCellViewModel?) {
        titleLabel.text = viewModel?.title
        descriptionLabel.text = viewModel?.description
        viewModel?.getImage(
            showLoadingHandler: { [weak self] isLoading in
                isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
            }, completionHandler: { [weak self] image in
                self?.imageView.image = image
            }
        )
    }
}
