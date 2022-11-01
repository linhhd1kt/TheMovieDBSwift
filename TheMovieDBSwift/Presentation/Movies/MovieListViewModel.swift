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
    private let items = PublishSubject<[Movie]>()
    
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
            .map { 1 }
            .bind(to: movieUseCase.input.fetchPopular)
            .disposed(by: disposeBag)
        
//        let resultItems = movieUseCase.output
//            .fetchPopularResult
//            .elements
//            .map { $0.results }
//            .redu
        
//        movieUseCase.output
//            .fetchPopularResult
//            .elements
//            .debug("XXX MovieListViewModel bind output to movie list observer")
//            .bind(to: movieListObserver)
//            .disposed(by: disposeBag)
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
    var moviesResult: ActionResult<Page<Movie>> {
        return movieUseCase.output.fetchPopularResult
    }
}
