//
//  DashboardViewController.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 19/10/2022.
//

import UIKit
import RxSwift

class DashboardViewController: RickViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let viewModel: DashboardViewModelType
    private let dataSource = DataSourceFactory().mak()
        
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
    }

    private func setupLayouts() {
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.register(MovieCollectionCell.self)
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 160, height: 320)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }
    
    private func bindInput(_ input: DashboardViewModelInputType) {
        rx.viewWillAppear
            .take(1)
            .map { 1 }
            .bind(to: input.fetchPopularMovies)
            .disposed(by: disposeBag)
    }
    
    private func bindOutput(_ output: DashboardViewModelOutputType) {
        output.moviesResult
            .map { [MovieSection(title: "Popular", items: $0)] }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension DashboardViewController: UIScrollViewDelegate { }
