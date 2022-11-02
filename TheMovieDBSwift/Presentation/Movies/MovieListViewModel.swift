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
    private let reloadObserver = PublishSubject<Void>()
    private let nextPageObserver = PublishSubject<Void>()
    private let movieSelectedObserver = PublishSubject<Movie?>()

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
            .withLatestFrom(movieListObserver.asObservable().map(\.page))
            .filter { $0 < 5 || $0 == 0 } // stop loading when first 5 page
            .map { $0 + 1 } // increase page by 1 when loading next page
            .bind(to: movieUseCase.input.fetchPopular)
            .disposed(by: disposeBag)
        
        reloadObserver
            .map { 1 }
            .bind(to: movieUseCase.input.fetchPopular)
            .disposed(by: disposeBag)

        let movieElements = movieUseCase.output.fetchPopularResult
            .elements
            .share()
        
        movieElements
            .filter { $0.page == 1 }
            .bind(to: movieListObserver)
            .disposed(by: disposeBag)
        movieElements
            .filter { $0.page > 1 }
            .bind(to: movieListObserver.append)
            .disposed(by: disposeBag)
    }
}

extension MovieListViewModel: MovieListViewModelInputType {
    var reloadTrigger: AnyObserver<Void> {
        return reloadObserver.asObserver()
    }
    var nextPageTrigger: AnyObserver<Void> {
        return nextPageObserver.asObserver()
    }
    var movieSelected: AnyObserver<Movie?> {
        return movieSelectedObserver.asObserver()
    }
}

extension MovieListViewModel: MovieListViewModelOutputType {
    var movieList: Observable<[Movie]> {
        return movieListObserver
            .map(\.results)
            .asObservable()
    }
    var loading: Observable<Bool> {
        return movieUseCase.output.fetchPopularResult.executing
    }
}
