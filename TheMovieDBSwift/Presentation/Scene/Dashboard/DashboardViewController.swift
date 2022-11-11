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
    
    @IBOutlet private weak var popularHeaderSectionView: UIView!
    @IBOutlet private weak var popularMovieContainerView: UIView!
    
    private var popularMovieCollectionView = RickCollectionView<MoviePage>(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
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
        setupLayouts()
        bindInput(viewModel.input)
        bindOutput(viewModel.output)
        popularMovieCollectionView.binding()
    }

    private func setupLayouts() {
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
    private func bindInput(_ input: DashboardViewModelInputType) {
        let viewWillAppear = rx.viewDidAppear.asObservable().take(1).map { 1 }
        Observable.merge(viewWillAppear, popularMovieCollectionView.nextPageTrigger)
            .bind(to: input.fetchPopularMovies)
            .disposed(by: disposeBag)
    }
    
    private func bindOutput(_ output: DashboardViewModelOutputType) {
        output.moviesResult
            .bind(to: popularMovieCollectionView.itemsResult)
            .disposed(by: disposeBag)
    } 
}

extension DashboardViewController: UIScrollViewDelegate { }
