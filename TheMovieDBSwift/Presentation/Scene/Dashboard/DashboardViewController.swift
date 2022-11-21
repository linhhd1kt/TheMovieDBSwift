//
//  DashboardViewController.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 19/10/2022.
//

import UIKit
import RxSwift

class DashboardViewController: RickViewController {
    fileprivate let maxHeaderHeight: CGFloat = 360
    fileprivate let minHeaderHeight: CGFloat = 180
    fileprivate var previousScrollOffset: CGFloat = 0
    @IBOutlet fileprivate weak var headerHeightContraint: NSLayoutConstraint!
    @IBOutlet private weak var containerScrollView: UIScrollView!
    @IBOutlet private weak var dashboardHeaderView: UIView!
    @IBOutlet private weak var searchView: RoundedSearchView!
    @IBOutlet private weak var popularItemSessionView: ItemSessionView!
    @IBOutlet private weak var freeItemSessionView: ItemSessionView!
    @IBOutlet private weak var trendingItemSessionView: ItemSessionView!
    
    // MARK: - Dependences
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
        freeItemSessionView.configure(title: "Free To Watch", categories: DiscoverCategory.freeItems)
        trendingItemSessionView.configure(title: "Trending", categories: DiscoverCategory.treding)
        containerScrollView.delegate = self
    }
    
    private func bindInput(_ input: DashboardViewModelInputType) {
        // popular
        Observable.combineLatest(popularItemSessionView.rx.nextPage,
                                 popularItemSessionView.rx.selectedCategory)
        .map { (page: $0, category: $1) }
        .bind(to: input.fetchDiscoverMovies)
        .disposed(by: disposeBag)
        // free watch
        Observable.combineLatest(freeItemSessionView.rx.nextPage,
                                 freeItemSessionView.rx.selectedCategory)
        .map { (page: $0, category: $1) }
        .bind(to: input.fetchFreeWatchMovies)
        .disposed(by: disposeBag)
        // trending
        trendingItemSessionView.rx.selectedCategory
            .bind(to: input.fetchTrending)
            .disposed(by: disposeBag)
    }
    
    private func bindOutput(_ output: DashboardViewModelOutputType) {
        // popular
        output.fetchPopularResult
            .bind(to: popularItemSessionView.rx.items)
            .disposed(by: disposeBag)
        // free watch
        output.fetchFreeWatchResult
            .bind(to: freeItemSessionView.rx.items)
            .disposed(by: disposeBag)
        // trending
        output.fetchTrendingResult
            .bind(to: trendingItemSessionView.rx.items)
            .disposed(by: disposeBag)
    }
}

extension DashboardViewController: UIScrollViewDelegate {
    func canAnimateHeader (_ scrollView: UIScrollView) -> Bool {
        let scrollViewMaxHeight = scrollView.frame.height + self.headerHeightContraint.constant - minHeaderHeight
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = (scrollView.contentOffset.y - previousScrollOffset)
        let isScrollingDown = scrollDiff > 0
        let isScrollingUp = scrollDiff < 0
        if canAnimateHeader(scrollView) {
            var newHeight = headerHeightContraint.constant
            if isScrollingDown {
                newHeight = max(minHeaderHeight, headerHeightContraint.constant - abs(scrollDiff))
            } else if isScrollingUp {
                newHeight = min(maxHeaderHeight, headerHeightContraint.constant + abs(scrollDiff))
            }
            if newHeight != headerHeightContraint.constant {
                headerHeightContraint.constant = newHeight
                setScrollPosition()
                previousScrollOffset = scrollView.contentOffset.y
            }
        }
    }
    func setScrollPosition() {
        self.containerScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
}
