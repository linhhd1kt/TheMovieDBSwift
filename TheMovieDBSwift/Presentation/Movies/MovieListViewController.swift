//
//  MovieListViewController.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import UIKit
import RxSwift

class MovieListViewController: RickViewController, UIScrollViewDelegate {
    @IBOutlet private weak var tableView: UITableView!
    private let viewModel: MovieListViewModelType
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: MovieListViewModelType = MovieListViewModel(), navigationViewModel: NavigationViewModelType) {
        self.viewModel = viewModel
        super.init(navigationViewModel: navigationViewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        bindInput(viewModel.input)
        bindOutput(viewModel.output)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)     
    }
    
    private func setupLayouts() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.register(UINib(nibName: MovieCell.className, bundle: nil), forCellReuseIdentifier: MovieCell.className)
        tableView.rowHeight = 40
        tableView.separatorStyle = .none
    }
    
    private func bindInput(_ input: MovieListViewModelInputType) {
        rx.viewWillAppear
            .take(1)
            .map { 1 }
            .bind(to: input.fetchPopularMovies)
            .disposed(by: disposeBag)
        tableView.rx.modelSelected(Movie.self)
            .bind(to: input.movieSelected)
            .disposed(by: disposeBag)
    }
    
    private func bindOutput(_ output: MovieListViewModelOutputType) {
        output.moviesResult
            .elements
            .map { $0.results }
            .bind(to: tableView.rx.items(cellIdentifier: MovieCell.className, cellType: MovieCell.self)) { _, model, cell in
                cell.configure(model)
            }
            .disposed(by: disposeBag)
    }
}
