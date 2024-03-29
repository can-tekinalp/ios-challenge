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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
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
        homeViewModel.isLoadingHandler = { [weak self] showLoading in
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
        cell.lineView.alpha = indexPath.row == homeViewModel.cellCount - 1 ? 0 : 1
        return cell
    }
}

// MARK: UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if headerView == nil {
            headerView = HomeHeaderView()
            headerView?.delegate = self
        }
        headerView?.configure(with: homeViewModel.headerViewModel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HomeHeaderView.cellSize.height
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == homeViewModel.cellCount - 1 {
            homeViewModel.fetchNextPage(
                onSuccess: { [weak self] in
                    self?.tableView.reloadData()
                }, onError: { [weak self] errorMessage in
                    self?.showError(message: errorMessage)
                }
            )
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = homeViewModel.cellViewModel(at: indexPath.row)
        routeToDetail(viewModel)
    }
}

// MARK: HomeHeaderViewDelegate
extension HomeViewController: HomeHeaderViewDelegate {
    
    func userTappedCollectionCell(_ cellViewModel: MovieCellViewModel) {
        routeToDetail(cellViewModel)
    }
}

// MARK: Helper
extension HomeViewController {

    private func routeToDetail(_ viewModel: MovieCellViewModel) {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        controller.detailViewModel = DetailViewModel(
            pageTitle: viewModel.detailPageTitle,
            movieId: "\(viewModel.movie.id)",
            detailPageServiceProtocol: DetailPageService()
        )
        navigationController?.pushViewController(controller, animated: true)
    }
}
