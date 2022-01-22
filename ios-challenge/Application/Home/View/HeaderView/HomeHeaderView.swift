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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "HomeHeaderCollectionCell", for: indexPath) as! HomeHeaderCollectionCell
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
}
