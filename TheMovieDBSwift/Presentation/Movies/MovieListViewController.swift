//
//  MovieListViewController.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import UIKit
import RxSwift
import RxCocoa

class MovieListViewController: RickViewController {
    private var tableView: RickTableView<MoviePage> = RickTableView<MoviePage>(frame: .zero, style: .plain)
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
        tableView.binding()
        bindInput(viewModel.input)
        bindOutput(viewModel.output)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)     
    }
    
    private func setupLayouts() {
        setupTableView()
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }
    
    private func setupTableView() {
//        tableView.rx.setDelegate(self).disposed(by: disposeBag)
//        tableView.register(MovieTableCell.self)
//        tableView.rowHeight = 40
//        tableView.separatorStyle = .none
    }
    
    private func bindInput(_ input: MovieListViewModelInputType) {
        Observable.merge(rx.viewDidAppear.asObservable().take(1).map { 1 },
                         tableView.nextPageTrigger)
            .debug("XXX input.nextPageTrigger")
            .bind(to: input.nextPageTrigger)
            .disposed(by: disposeBag)
        
//        tableView.nextPageObserver.asObservable()
//            .bind(to: input.nextPageTrigger)
//            .disposed(by: disposeBag)

//        tableView.nextPageObserver
//            .debug("XXX MovieListViewController nextPageObserver")
//            .bind(to: input.nextPageTrigger)
//            .disposed(by: disposeBag)
//        if let refreshControl = tableView.refreshControl {
//            Observable.merge(rx.viewDidAppear.asObservable().take(1),
//                             refreshControl.rx.controlEvent(.valueChanged).asObservable())
//                .bind(to: input.reloadTrigger)
//                .disposed(by: disposeBag)
//        }
//        rx.viewDidAppear.asObservable().take(1)
//            .map { 1 }
//            .debug("XXX viewDidAppear")
//            .bind(to: tableView.nextPageObserver)
//            .disposed(by: disposeBag)
//        Observable.merge(tableView.rx.reachEnd, rx.viewDidAppear.asObservable().take(1))
//            .bind(to: input.nextPageTrigger)
//            .disposed(by: disposeBag)
//        tableView.rx.modelSelected(Movie.self)
//            .bind(to: input.movieSelected)
//            .disposed(by: disposeBag)
    }
    
    private func bindOutput(_ output: MovieListViewModelOutputType) {
        output.fetchMovieResult
            .debug("XXX MovieListViewController fetchMovieResult")
//            .subscribe()
//            .elements
            .bind(to: tableView.resultObserver.append)
            .disposed(by: disposeBag)
            
//        output.movieList
//            .bind(to: tableView.rx.items(cellIdentifier: MovieTableCell.className, cellType: MovieTableCell.self)) { _, model, cell in
//                cell.configure(model)
//            }
//            .disposed(by: disposeBag)
//        output.loading
//            .bind(to: rx.loading)
//            .disposed(by: disposeBag)
//        if let refreshControl = tableView.refreshControl {
//            output.loading
//                .bind(to: refreshControl.rx.isRefreshing)
//                .disposed(by: disposeBag)
//        }
    }
}

extension MovieListViewController: UIScrollViewDelegate { }
