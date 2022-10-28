//
//  MovieUseCase.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import RxSwift
import NSObject_Rx

class MovieUseCase {
    // MARK: - Dependency
    private let respository: MovieRepositoryType
    private let translator: MovieTranslatorType
    // MARK: - Input
    private let fetchPopularMoviePageObserver = PublishSubject<Int>()
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
            .bind(to: respository.fetchPopular.inputs)
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
}

// MARK: - MovieUseCaseOutputType
extension MovieUseCase: MovieUseCaseOutputType {
    var fetchPopularResult: ActionResult<Page<Movie>> {
        return respository.fetchPopular.toResult()
            .map { self.translator.toPage(response: $0) }
    }
}

extension MovieUseCase: HasDisposeBag {}
