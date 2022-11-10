//
//  DashboardViewController.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 19/10/2022.
//

import UIKit
import RxSwift

class DashboardViewController: RickViewController {
//    @IBOutlet private weak var collectionView: UICollectionView!
    
    @IBOutlet private weak var popularMovieContainerView: UIView!
    private var popularMovieCollectionView = RickCollectionView<MoviePage>(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    private let viewModel: DashboardViewModelType
//    private let dataSource = DataSourceFactory().make()
        
    // MARK: - Initialization
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
        setupLayouts()
        bindInput(viewModel.input)
        bindOutput(viewModel.output)
        popularMovieCollectionView.binding()
    }

    private func setupLayouts() {
//        setupCollectionView()
        setupPopularCollectionView()
    }
    
    private func setupPopularCollectionView() {
        popularMovieCollectionView.frame = popularMovieContainerView.bounds
        popularMovieContainerView.addSubview(popularMovieCollectionView)
        popularMovieCollectionView.register(MovieCollectionCell.self)
        popularMovieCollectionView.configure(identifier: MovieCollectionCell.className, type: MovieCollectionCell.self) { _, model, cell in
            cell.configure(model)
        }
    }

//    private func setupCollectionView() {
//        collectionView.register(MovieCollectionCell.self)
//        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 160, height: 320)
//        layout.scrollDirection = .horizontal
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
//        layout.minimumLineSpacing = 0
//        collectionView.collectionViewLayout = layout
//    }
    
    private func bindInput(_ input: DashboardViewModelInputType) {
//        rx.viewWillAppear
//            .take(1)
//            .map { 1 }
//            .bind(to: input.fetchPopularMovies)
//            .disposed(by: disposeBag)
        let viewWillAppear = rx.viewDidAppear.asObservable().take(1).map { 1 }
        Observable.merge(viewWillAppear, popularMovieCollectionView.nextPageTrigger)
            .bind(to: input.fetchPopularMovies)
            .disposed(by: disposeBag)
    }
    
    private func bindOutput(_ output: DashboardViewModelOutputType) {
//        output.moviesResult
//            .map { [MovieSection(title: "Popular", items: $0)] }
//            .bind(to: collectionView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
        output.moviesResult
            .debug("XXX moviesResult")
            .bind(to: popularMovieCollectionView.itemsResult)
            .disposed(by: disposeBag)
    }
    
//    private func bindInput(_ input: MovieListViewModelInputType) {
//    }
//
//    private func bindOutput(_ output: MovieListViewModelOutputType) {
//        output.fetchMovieResult
//            .bind(to: tableView.itemsResult)
//            .disposed(by: disposeBag)
//    }
}

extension DashboardViewController: UIScrollViewDelegate { }
