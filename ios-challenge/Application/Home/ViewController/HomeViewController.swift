//
//  HomeViewController.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    private var headerView: HomeHeaderView?
    var activityIndicatorManager: ActivityIndicatorManager = .shared
    var homeViewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchHomePage()
    }

    private func fetchHomePage() {
        homeViewModel.fetchHomePage (
            onSuccess: { [weak self] in
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }, onError: { [weak self] errorMessage in
                self?.showError(message: errorMessage)
            }
        )
    }
    
    @objc private func refreshHomePage() {
        fetchHomePage()
    }
}

// MARK: Setup
extension HomeViewController {
    
    private func setup() {
        setupTableView()
        bindViewModel()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "HomeTableCell", bundle: Bundle(for: HomeTableCell.self))
        tableView.register(nib, forCellReuseIdentifier: "HomeTableCell")
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.refreshControl = refreshControl
        tableView.separatorStyle = .none
        refreshControl.addTarget(self, action: #selector(refreshHomePage), for: .valueChanged)
    }
    
    private func bindViewModel() {
        homeViewModel.showLoadingHandler = { [weak self] showLoading in
            if showLoading {
                self?.activityIndicatorManager.show()
            } else {
                self?.activityIndicatorManager.hide()
            }
        }
    }
}


// MARK: UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as! HomeTableCell
        cell.configure(with: homeViewModel.cellViewModel(at: indexPath.row))
        return cell
    }
}


// MARK: UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if headerView == nil {
            headerView = HomeHeaderView()
        }
        headerView?.configure(with: homeViewModel.headerViewModel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HomeHeaderView.cellSize.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select")
    }
}
