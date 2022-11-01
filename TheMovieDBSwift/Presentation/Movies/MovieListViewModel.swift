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
    private let nextPageObserver = PublishSubject<Void>()
    private let movieSelectedObserver = PublishSubject<Movie?>()
    // MARK: - Output
    private let errorObserver = BehaviorSubject<String>(value: "")
    private let movieListObserver = BehaviorSubject<Page<Movie>>(value: .empty)
    
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
            .withLatestFrom(movieListObserver)
            .map { $0.page + 1 } // Magic of loading more here
            .bind(to: movieUseCase.input.fetchPopular)
            .disposed(by: disposeBag)
        // Magic of loading more here
        movieUseCase.output.fetchPopularResult
            .elements
            .skip(while: { page in
                // TODO remove + 35697(cheat only for skip action) when real running,
                return page.page + 35696 >= page.totalPages
            })
            .bind(to: movieListObserver)
            .disposed(by: disposeBag)
    }
}

extension MovieListViewModel: MovieListViewModelInputType {
    var nextPageTrigger: AnyObserver<Void> {
        return nextPageObserver.asObserver()
    }
    var movieSelected: AnyObserver<Movie?> {
        return movieSelectedObserver.asObserver()
    }
}

extension MovieListViewModel: MovieListViewModelOutputType {
    var movieList: Observable<[Movie]> {
        return movieListObserver.asObservable()
            .map(\.results)
            .scan([], accumulator: +) // Magic of loading more here
    }
    var loading: Observable<Bool> {
        return movieUseCase.output.fetchPopularResult.executing
    }
}
