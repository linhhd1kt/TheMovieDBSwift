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
    private let fetchDiscoverMoviesObserver = PublishSubject<(page: Int, category: PopularCategory)>()
    // MARK: - Output
    private let errorObserver = BehaviorSubject<String>(value: "")
    private let movieListObserver = BehaviorSubject<MoviePage>(value: .init())
    
    init(movieUseCase: MovieUseCaseType = MovieUseCase()) {
        self.movieUseCase = movieUseCase
        super.init()
        self.binding()
    }
    
    private func binding() {
        fetchDiscoverMoviesObserver
            .bind(to: movieUseCase.input.fetchDicover)
            .disposed(by: disposeBag)
        movieUseCase.output
            .fetchDiscoverResult
            .elements
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
    var fetchDiscoverMovies: AnyObserver<(page: Int, category: PopularCategory)> {
        return fetchDiscoverMoviesObserver.asObserver()
    }
}

extension DashboardViewModel: DashboardViewModelOutputType {
    var moviesResult: Observable<MoviePage> {
        return movieListObserver.asObservable()
    }
}
