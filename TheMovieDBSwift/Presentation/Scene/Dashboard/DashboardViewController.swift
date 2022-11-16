//
//  DashboardViewController.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 19/10/2022.
//

import UIKit
import RxSwift

class DashboardViewController: RickViewController {
    @IBOutlet private weak var dashboardHeaderView: UIView!
    @IBOutlet private weak var searchView: RoundedSearchView!
    @IBOutlet private weak var popularItemSessionView: ItemSessionView!
    @IBOutlet private weak var freeItemSessionView: ItemSessionView!
    
    private let viewModel: DashboardViewModelType
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: DashboardViewModelType,
         navigationViewModel: NavigationViewModelType) {
        self.viewModel = viewModel
        super.init(navigationViewModel: navigationViewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindInput(viewModel.input)
        bindOutput(viewModel.output)
        setupLayouts()
    }
    
    private func setupLayouts() {
        popularItemSessionView.configure(title: "What's Popular", categories: DiscoverCategory.popularItems)
        freeItemSessionView.configure(title: "What's Popular", categories: DiscoverCategory.freeItems)
    }
    
    private func bindInput(_ input: DashboardViewModelInputType) {
        Observable.combineLatest(popularItemSessionView.rx.nextPage,
                                 popularItemSessionView.rx.selectedCategory)
        .map { (page: $0, category: $1) }
        .bind(to: input.fetchDiscoverMovies)
        .disposed(by: disposeBag)
        
        Observable.combineLatest(freeItemSessionView.rx.nextPage,
                                 freeItemSessionView.rx.selectedCategory)
        .map { (page: $0, category: $1) }
        .bind(to: input.fetchFreeWatchMovies)
        .disposed(by: disposeBag)
    }
    
    private func bindOutput(_ output: DashboardViewModelOutputType) {
        output.fetchPopularResult
            .bind(to: popularItemSessionView.rx.items)
            .disposed(by: disposeBag)
        output.fetchFreeWatchResult
            .bind(to: freeItemSessionView.rx.items)
            .disposed(by: disposeBag)
    }
}

extension DashboardViewController: UIScrollViewDelegate { }
