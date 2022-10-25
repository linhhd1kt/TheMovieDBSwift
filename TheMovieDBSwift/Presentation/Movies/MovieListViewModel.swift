//
//  MovieListViewModel.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import RxSwift
import RxCocoa
import NSObject_Rx
import Action

final class MovieListViewModel: BaseViewModel {
    // MARK: - Dependency
    private let movieUseCase: MovieUseCaseType

    // MARK: - Input
    // only make private please
    private let fetchPopularMoviesObserver = PublishSubject<Int>()
    private let movieSelectedObserver = PublishSubject<Movie?>()
    // MARK: - Output
    private let errorObserver = BehaviorSubject<String>(value: "")
    private let movieListObserver = PublishSubject<[Movie]>()
    
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
        fetchPopularMoviesObserver
            .bind(to: movieUseCase.input.fetchPopular)
            .disposed(by: disposeBag)
        movieUseCase.output
            .fetchPopularResult
            .elements
            .map { $0.results }
            .bind(to: movieListObserver)
            .disposed(by: disposeBag)
    }
}

extension MovieListViewModel: MovieListViewModelInputType {
    var fetchPopularMovies: AnyObserver<Int> {
        return fetchPopularMoviesObserver.asObserver()
    }
    var movieSelected: AnyObserver<Movie?> {
        return movieSelectedObserver.asObserver()
    }
}

extension MovieListViewModel: MovieListViewModelOutputType {
    var moviesResult: ActionResult<Page<Movie>> {
        return movieUseCase.output.fetchPopularResult
    }
}

