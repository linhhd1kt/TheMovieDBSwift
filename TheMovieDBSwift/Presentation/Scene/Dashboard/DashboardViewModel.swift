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
    private let fetchPopularObserver = PublishSubject<(page: Int, category: DiscoverCategory)>()
    private let fetchFreeWatchObserver = PublishSubject<(page: Int, category: DiscoverCategory)>()
    private let fetchTrendingObserver = PublishSubject<DiscoverCategory>()
    // MARK: - Output
    private let errorObserver = BehaviorSubject<String>(value: "")
    private let popularResultObserver = BehaviorSubject<MoviePage>(value: .init())
    private let freeWatchResultObserver = BehaviorSubject<MoviePage>(value: .init())
    private let trendingResultObserver = BehaviorSubject<MoviePage>(value: .init())
    
    init(movieUseCase: MovieUseCaseType = MovieUseCase()) {
        self.movieUseCase = movieUseCase
        super.init()
        self.binding()
    }
    
    private func binding() {
        // fetch popular
        fetchPopularObserver
            .bind(to: movieUseCase.input.fetchPopular)
            .disposed(by: disposeBag)
        movieUseCase.output
            .fetchPopularResult
            .elements
            .bind(to: popularResultObserver)
            .disposed(by: disposeBag)
        // fetch free watch
        fetchFreeWatchObserver
            .filter { $0.category == .movie }
            .bind(to: movieUseCase.input.fetchFreeWatchMovie)
            .disposed(by: disposeBag)
        fetchFreeWatchObserver
            .filter { $0.category == .tv }
            .bind(to: movieUseCase.input.fetchFreeWatchTV)
            .disposed(by: disposeBag)
        Observable.merge(movieUseCase.output.fetchFreeWatchMovieResult.elements,
                         movieUseCase.output.fetchFreeWatchTVResult.elements)
            .bind(to: freeWatchResultObserver)
            .disposed(by: disposeBag)
        // fetch trending
        fetchTrendingObserver
            .map { TimeWindow(rawValue: $0.rawValue) ?? .day }
            .bind(to: movieUseCase.input.fetchTrending)
            .disposed(by: disposeBag)
        movieUseCase.output
            .fetchTrendingResult
            .elements
            .bind(to: trendingResultObserver)
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
    var fetchDiscoverMovies: AnyObserver<(page: Int, category: DiscoverCategory)> {
        return fetchPopularObserver.asObserver()
    }
    var fetchFreeWatchMovies: AnyObserver<(page: Int, category: DiscoverCategory)> {
        return fetchFreeWatchObserver.asObserver()
    }
    var fetchTrending: AnyObserver<DiscoverCategory> {
        return fetchTrendingObserver.asObserver()
    }
}

extension DashboardViewModel: DashboardViewModelOutputType {
    var fetchPopularResult: Observable<MoviePage> {
        return popularResultObserver.asObservable()
    }
    var fetchFreeWatchResult: Observable<MoviePage> {
        return freeWatchResultObserver.asObservable()
    }
    var fetchTrendingResult: Observable<MoviePage> {
        return trendingResultObserver.asObservable()
    }
}
