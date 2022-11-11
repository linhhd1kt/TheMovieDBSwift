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
    // only make private please
//    private let reloadObserver = PublishSubject<Void>()
    private let nextPageObserver = PublishSubject<Int>()
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
        
        movieUseCase.output.fetchPopularResult
            .elements
            .bind(to: movieListObserver)
            .disposed(by: disposeBag)
    }
}

extension MovieListViewModel: MovieListViewModelInputType {
    var nextPageTrigger: AnyObserver<Int> {
        return nextPageObserver.asObserver()
    }
}

extension MovieListViewModel: MovieListViewModelOutputType {
    var fetchMovieResult: Observable<MoviePage> {
        return movieListObserver.asObservable()
    }
}
