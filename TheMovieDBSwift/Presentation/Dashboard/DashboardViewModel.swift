//
//  DashboardViewModel.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import RxSwift
import RxCocoa
import Action

final class DashboardViewModel: BaseViewModel {
    // MARK: - Dependency
    private let movieUseCase: MovieUseCaseType

    // MARK: - Input
    private let fetchPopularMoviesObserver = BehaviorSubject<Int>(value: 1)
    // MARK: - Output
    private let errorObserver = BehaviorSubject<String>(value: "")
    private let movieListObserver = BehaviorSubject<[Movie]>(value: [])
    
    init(movieUseCase: MovieUseCaseType = MovieUseCase()) {
        self.movieUseCase = movieUseCase
        super.init()
        self.binding()
    }
    
    private func binding() {
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

extension DashboardViewModel: DashboardViewModelType {
    var input: DashboardViewModelInputType {
        return self
    }
    var output: DashboardViewModelOutputType {
        return self
    }
}

extension DashboardViewModel: DashboardViewModelInputType {
    var fetchPopularMovies: AnyObserver<Int> {
        return fetchPopularMoviesObserver.asObserver()
    }
}

extension DashboardViewModel: DashboardViewModelOutputType {
    var moviesResult: Observable<[Movie]> {
        return movieListObserver.asObservable()
    }
}
