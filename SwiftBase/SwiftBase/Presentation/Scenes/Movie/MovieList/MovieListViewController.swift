//
//  MovieListViewController.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Domain
import RxCocoa
import RxSwift
import Extension
import Data

class MovieListViewController: RickViewController {
  private var tableView: RickTableView<MoviePage> = .init(frame: .zero, style: .plain)
  private let viewModel: MovieListViewModelType

  // MARK: - Initialization

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  init(viewModel: MovieListViewModelType, navigationViewModel: NavigationViewModelType) {
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
  }

  private func setupTableView() {
    view.attach(tableView)
    tableView.register(MovieTableCell.self)
    tableView.configure(identifier: MovieTableCell.className, type: MovieTableCell.self) { _, model, cell in
      cell.configure(model)
    }
  }

  private func bindInput(_ input: MovieListViewModelInputType) {
    let viewWillAppear = rx.viewDidAppear.asObservable().take(1).map { 1 }
    Observable.merge(viewWillAppear, tableView.nextPageTrigger)
      .map { (page: $0, category: .movie) }
      .bind(to: input.nextPageTrigger)
      .disposed(by: disposeBag)
  }

  private func bindOutput(_ output: MovieListViewModelOutputType) {
    output.fetchMovieResult
      .bind(to: tableView.itemsResult)
      .disposed(by: disposeBag)
  }
}

extension MovieListViewController: UIScrollViewDelegate {}
