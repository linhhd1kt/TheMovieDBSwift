//
//  MovieUseCase.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import RxSwift

class MovieUseCase {
    // MARK: - Dependency
    private let respository: MovieRepositoryType
    private let translator: MovieTranslatorType
    // MARK: - Input
    private let fetchPopularObserver = PublishSubject<(page: Int, category: DiscoverCategory)>()
    private let fetchFreeWatchMovieObserver = PublishSubject<(page: Int, category: DiscoverCategory)>()
    private let fetchFreeWatchTVObserver = PublishSubject<(page: Int, category: DiscoverCategory)>()
    // MARK: - Other
    
    init(respository: MovieRepositoryType = MovieRepository(),
         translator: MovieTranslatorType = MovieTranslator()) {
        self.respository = respository
        self.translator = translator
        bindInput()
    }

    private func bindInput() {
        fetchPopularObserver
            .withUnretained(self)
            .map { this, info in
                this.translator.toPopularRequest(page: info.page, category: info.category)
            }
            .bind(to: respository.fetchPopularMovie.inputs)
            .disposed(by: disposeBag)
        
        fetchFreeWatchMovieObserver
            .map { $0.page }
            .withUnretained(self)
            .map { this, page in this.translator.toFreeWatchMovieRequest(page: page) }
            .bind(to: respository.fetchFreeWatchMovie.inputs)
            .disposed(by: disposeBag)
        
        fetchFreeWatchTVObserver
            .map { $0.page }
            .withUnretained(self)
            .map { this, page in this.translator.toFreeWatchTVRequest(page: page) }
            .bind(to: respository.fetchFreeWatchTV.inputs)
            .disposed(by: disposeBag)
    }
}

// MARK: - MovieUseCaseType
extension MovieUseCase: MovieUseCaseType {
    var input: MovieUseCaseInputType { return self }
    var output: MovieUseCaseOutputType { return self }
}

// MARK: - MovieUseCaseInputType
extension MovieUseCase: MovieUseCaseInputType {
    var fetchPopular: AnyObserver<(page: Int, category: DiscoverCategory)> {
        fetchPopularObserver.asObserver()
    }    
    var fetchFreeWatchMovie: AnyObserver<(page: Int, category: DiscoverCategory)> {
        return fetchFreeWatchMovieObserver.asObserver()
    }
    var fetchFreeWatchTV: AnyObserver<(page: Int, category: DiscoverCategory)> {
        return fetchFreeWatchTVObserver.asObserver()
    }
}

// MARK: - MovieUseCaseOutputType
extension MovieUseCase: MovieUseCaseOutputType {
    var fetchPopularResult: ActionResult<MoviePage> {
        return respository.fetchPopularMovie.toResult()
            .map { self.translator.toPage(response: $0) }
    }
    var fetchFreeWatchMovieResult: ActionResult<MoviePage> {
        return respository.fetchFreeWatchMovie.toResult()
            .map { self.translator.toPage(response: $0) }
    }    
    var fetchFreeWatchTVResult: ActionResult<MoviePage> {
        return respository.fetchFreeWatchTV.toResult()
            .map { self.translator.toPage(response: $0) }
    }
}

extension MovieUseCase: HasDisposeBag {}
