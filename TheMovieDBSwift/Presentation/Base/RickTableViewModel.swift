//
//  RickTableViewModel.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 05/11/2022.
//

import RxSwift

protocol RickTableViewModelType {
    var input: RickTableViewModelInputType { get }
    var output: RickTableViewModelOutputType { get }
}

protocol RickTableViewModelInputType {
    var startFetch: AnyObserver<Void> { get }
}

protocol RickTableViewModelOutputType {
    var fetchResult: Observable<[Movie]> { get }
}

class RickTableViewModel {
    // MARK: - Dependencies
    // TODO: use service facade to inject usecase here
    private let usecase: MovieUseCase = MovieUseCase()
    
    // MARK: - Input
    private let fetchObserver = PublishSubject<Void>()
    // MARK: - Output
    private let resultObserver = BehaviorSubject<[Movie]>(value: [])
    
    init() {
        binding()
    }
    
    private func binding() {
        fetchObserver
            .map { 1 }
            .debug("XXX RickTableViewModel fetchObserver")
            .bind(to: usecase.input.fetchPopular)
            .disposed(by: disposeBag)
        usecase.output.fetchPopularResult
            .elements
            .map(\.results)
            .bind(to: resultObserver)
            .disposed(by: disposeBag)
    }
}

extension RickTableViewModel: RickTableViewModelType {
    var input: RickTableViewModelInputType {
        return self
    }
    var output: RickTableViewModelOutputType {
        return self
    }
}

extension RickTableViewModel: RickTableViewModelInputType {
    var startFetch: AnyObserver<Void> {
        return fetchObserver.asObserver()
    }
}

extension RickTableViewModel: RickTableViewModelOutputType {
    var fetchResult: Observable<[Movie]> {
        return resultObserver.asObservable()
    }
}

extension RickTableViewModel: HasDisposeBag { }
