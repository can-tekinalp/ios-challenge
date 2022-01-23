//
//  HomeHeaderView.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

import UIKit

protocol HomeHeaderViewDelegate: AnyObject {
    func userTappedCollectionCell(_ cellViewModel: MovieCellViewModel)
}

final class HomeHeaderView: UIView {
    
    static let cellSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.6)
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var viewModel: HomePageHeaderViewModel?
    weak var delegate: HomeHeaderViewDelegate?
    
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
    
    func configure(with viewModel: HomePageHeaderViewModel?) {
        guard let viewModel = viewModel else { return }
        self.viewModel = viewModel
        pageControl.numberOfPages = viewModel.cellCount
        if viewModel.shouldReloadData {
            viewModel.shouldReloadData = false
            collectionView.reloadData()
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
}

// MARK: Setup
extension HomeHeaderView {

    private func setup() {
        let nib = UINib(nibName: "HomeHeaderCollectionCell", bundle: Bundle(for: HomeHeaderCollectionCell.self))
        collectionView.register(nib, forCellWithReuseIdentifier: "HomeHeaderCollectionCell")
        pageControl.isUserInteractionEnabled = false
    }
}

// MARK: UICollectionViewDataSource
extension HomeHeaderView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.cellCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeHeaderCollectionCell", for: indexPath) as! HomeHeaderCollectionCell
        cell.configure(with: viewModel?.cellViewModel(at: indexPath.row))
        return cell
    }
}

// MARK: UICollectionViewDataSource
extension HomeHeaderView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel?.cellViewModel(at: indexPath.row) else { return }
        delegate?.userTappedCollectionCell(viewModel)
    }
}

// MARK: UICollectionViewDataSource
extension HomeHeaderView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return HomeHeaderView.cellSize
    }
}

// MARK: UIScrollViewDelegate
extension HomeHeaderView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
}
