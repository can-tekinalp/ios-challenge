//
//  HomeHeaderView.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

import UIKit

final class HomeHeaderView: UIView {
    
    static let cellSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.6)
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var viewModel: HomePageHeaderViewModel?
    
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
        print("did select")
    }
}

// MARK: UICollectionViewDataSource
extension HomeHeaderView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return HomeHeaderView.cellSize
    }
}

extension UIView {

    func fillSuperView() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
    
    func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }
}
