//
//  DetailViewController.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

import SafariServices
import SDWebImage

final class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoView: DetailPageInfoView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var loadingView: UIView!
    
    var detailViewModel: DetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func fetch() {
        detailViewModel.fetchDetails(
            onSuccess: { [weak self] in
                self?.fill()
            }, onError: { [weak self] error in
                self?.showError(message: error)
            }
        )
    }
    
    private func fill() {
        titleLabel.text = detailViewModel.pageTitle
        imageView.sd_setImage(with: detailViewModel.imageUrl, completed: nil)
        infoView.configure(with: detailViewModel)
        textView.attributedText = detailViewModel.description
        view.layoutIfNeeded()
    }
}

// MARK: Setup
extension DetailViewController {
    
    private func setup() {
        titleLabel.textColor = .textBlack
        textView.textColor = .textBlack
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        title = detailViewModel.pageTitle
        imageView.backgroundColor = .systemGray
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
        loadingView.isHidden = false
        infoView.delegate = self
        bindViewModel()
    }
    
    private func bindViewModel() {
        detailViewModel.showLoadingHandler = { [weak self] showLoading in
            if showLoading {
                self?.loadingView.isHidden = false
            } else {
                self?.loadingView.isHidden = true
            }
        }
    }
}

// MARK: DetailPageInfoViewDelegate
extension DetailViewController: DetailPageInfoViewDelegate {
    
    func userDidTapImdbButton() {
        guard let url = detailViewModel.imdbUrl else {
            showError(message: unexpectedErrorMessage)
            return
        }
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true, completion: nil)
    }
}
