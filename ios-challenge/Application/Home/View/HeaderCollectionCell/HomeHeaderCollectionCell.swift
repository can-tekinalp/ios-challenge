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
    
    var index: Int = -1

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with viewModel: MovieCellViewModel?, index: Int) {
        self.index = index
        titleLabel.text = viewModel?.title
        descriptionLabel.text = viewModel?.description
        viewModel?.delegate = self
        viewModel?.getImage(for: index)
    }
}

extension HomeHeaderCollectionCell: MovieCellViewModelDelegate {
    
    func showLoadingIndicator(_ isLoading: Bool, for index: Int) {
        guard self.index == index else { return }
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    func imageLoadCompleted(_ image: UIImage?, for index: Int) {
        guard self.index == index else { return }
        imageView.image = image
    }
}
