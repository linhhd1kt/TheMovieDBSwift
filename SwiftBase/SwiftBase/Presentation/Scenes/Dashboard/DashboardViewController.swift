//
//  DashboardViewController.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Design
import Domain
import RxSwift
import UIKit
import Data
import Extension

class DashboardViewController: RickViewController {
  @IBOutlet private var containerScrollView: UIScrollView!
  @IBOutlet fileprivate var headerHeightContraint: NSLayoutConstraint!
  @IBOutlet private var headerView: StretchyView!
  @IBOutlet private var searchView: RoundedSearchView!
  @IBOutlet private var popularItemSessionView: ItemSessionView!
  @IBOutlet private var freeItemSessionView: ItemSessionView!
  @IBOutlet private var trendingItemSessionView: ItemSessionView!

  // MARK: - Dependences

  private let viewModel: DashboardViewModelType

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  init(viewModel: DashboardViewModelType,
       navigationViewModel: NavigationViewModelType)
  {
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
    headerView.configure(headerHeightContraint, scrollView: containerScrollView)
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
      .elements
      .bind(to: popularItemSessionView.rx.items)
      .disposed(by: disposeBag)
    // free watch
    output.fetchFreeWatchMoviesResult
      .elements
      .bind(to: freeItemSessionView.rx.items)
      .disposed(by: disposeBag)
    // trending
    output.fetchTrendingMoviesResult
      .elements
      .bind(to: trendingItemSessionView.rx.items)
      .disposed(by: disposeBag)
    
    Observable.merge(output.fetchPopularResult.errors,
                     output.fetchFreeWatchMoviesResult.errors,
                     output.fetchTrendingMoviesResult.errors)
    .bind(to: rx.showError)
    .disposed(by: disposeBag)
  }
}
