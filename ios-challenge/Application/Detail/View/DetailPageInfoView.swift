//
//  DetailPageInfoView.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 23.01.2022.
//

import UIKit

protocol DetailPageInfoViewDelegate: AnyObject {
    func userDidTapImdbButton()
}

final class DetailPageInfoView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var yellowCircleView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var viewModel: DetailViewModel?
    weak var delegate: DetailPageInfoViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initXib()
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initXib()
        setup()
    }
    
    private func initXib() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        contentView.fillSuperView()
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear
    }
    
    func configure(with viewModel: DetailViewModel?) {
        rateLabel.attributedText = viewModel?.rating
        dateLabel.textColor = .textBlack
        dateLabel.text = viewModel?.date
    }
}

// MARK: Setup
extension DetailPageInfoView {

    private func setup() {
        yellowCircleView.backgroundColor = .yellow
        yellowCircleView.layer.cornerRadius = 2
        dateLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
    }
}

// MARK: Actions
extension DetailPageInfoView {

    @IBAction func imdbLogoTapped(_ sender: Any) {
        delegate?.userDidTapImdbButton()
    }
}

extension NSMutableAttributedString {
    
    static func += (left: NSMutableAttributedString, right: String) -> NSMutableAttributedString {
        let rightAttr = NSMutableAttributedString(string: right)
        left.append(rightAttr)
        return left
    }

    static func += (left: NSMutableAttributedString, right: NSAttributedString) -> NSMutableAttributedString {
        left.append(right)
        return left
    }
}
