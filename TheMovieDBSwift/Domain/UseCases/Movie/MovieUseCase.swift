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
    private let fetchPopularMoviePageObserver = PublishSubject<Int>()
    private let fetchDiscoverMoviePageObserver = PublishSubject<Int>()
    // MARK: - Other
    
    init(respository: MovieRepositoryType = MovieRepository(),
         translator: MovieTranslatorType = MovieTranslator()) {
        self.respository = respository
        self.translator = translator
        bindInput()
    }

    private func bindInput() {
        fetchPopularMoviePageObserver
            .withUnretained(self)
            .map { this, page in
                this.translator.toPopularRequest(page: page) }
            .bind(to: respository.fetchPopularMovie.inputs)
            .disposed(by: disposeBag)
        fetchDiscoverMoviePageObserver
            .withUnretained(self)
            .map { this, page in
                this.translator.toPopularRequest(page: page) }
            .bind(to: respository.fetchPopularMovie.inputs)
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
    var fetchPopular: AnyObserver<Int> {
        return fetchPopularMoviePageObserver.asObserver()
    }
    var fetchDicover: AnyObserver<Int> {
        return fetchDiscoverMoviePageObserver.asObserver()
    }
}

// MARK: - MovieUseCaseOutputType
extension MovieUseCase: MovieUseCaseOutputType {
    var fetchDiscoverResult: ActionResult<MoviePage> {
        return respository.fetchDiscoverMovie.toResult()
            .map { self.translator.toPage(response: $0) }
    }
    
    var fetchPopularResult: ActionResult<MoviePage> {
        return respository.fetchPopularMovie.toResult()
            .map { self.translator.toPage(response: $0) }
    }
}

extension MovieUseCase: HasDisposeBag {}
