//
//  MovieListViewModel.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import RxSwift
import RxCocoa
import Action

final class MovieListViewModel: BaseViewModel {
    // MARK: - Dependency
    private let movieUseCase: MovieUseCaseType

    // MARK: - Input
    private let nextPageObserver = PublishSubject<(page: Int, category: DiscoverCategory)>()
//    private let movieSelectedObserver = PublishSubject<Movie?>()

    // MARK: - Output
    private let errorObserver = BehaviorSubject<String>(value: "")
    private var movieListObserver = BehaviorRelay<MoviePage>(value: .empty)
    
    init(movieUseCase: MovieUseCaseType = MovieUseCase()) {
        self.movieUseCase = movieUseCase
        super.init()
        self.binding()
    }
}

extension MovieListViewModel: MovieListViewModelType {
    var input: MovieListViewModelInputType {
        return self
    }

    var output: MovieListViewModelOutputType {
        return self
    }
    
    func binding() {
        nextPageObserver
            .bind(to: movieUseCase.input.fetchPopular)
            .disposed(by: disposeBag)
        movieUseCase
            .output
            .fetchPopularResult
            .elements
            .bind(to: movieListObserver)
            .disposed(by: disposeBag)
    }
}

extension MovieListViewModel: MovieListViewModelInputType {
    var nextPageTrigger: AnyObserver<(page: Int, category: DiscoverCategory)> {
        return nextPageObserver.asObserver()
    }
}

extension MovieListViewModel: MovieListViewModelOutputType {
    var fetchMovieResult: Observable<MoviePage> {
        return movieListObserver.asObservable()
    }
}
