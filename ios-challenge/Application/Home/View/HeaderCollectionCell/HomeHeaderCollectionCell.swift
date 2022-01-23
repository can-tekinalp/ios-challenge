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
    
    private var viewModel: MovieCellViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        activityIndicator.stopAnimating()
        viewModel?.cancelGetImage()
    }
    
    func configure(with viewModel: MovieCellViewModel?) {
        self.viewModel = viewModel
        titleLabel.text = viewModel?.title
        descriptionLabel.text = viewModel?.description
        viewModel?.delegate = self
        viewModel?.getImage()
    }
}

extension HomeHeaderCollectionCell: MovieCellViewModelDelegate {
    
    func showLoadingIndicator(_ isLoading: Bool) {
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    func imageLoadCompleted(_ image: UIImage?) {
        imageView.image = image
    }
}
