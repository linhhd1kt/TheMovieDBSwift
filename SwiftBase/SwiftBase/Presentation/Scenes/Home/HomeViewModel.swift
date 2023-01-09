//
//  HomeViewModel.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Domain
import RxSwift

public final class HomeViewModel: BaseViewModel {
  // MARK: - Dependency

//    private let usecase: AuthUseCaseType

  // MARK: - Input

  private let fetchShopListObserver = BehaviorSubject<Void>(value: ())

  // MARK: - Output

  private let shopListResultObserver = BehaviorSubject<String>(value: "Empty")

  override public init() {
    super.init()
    binding()
  }

  private func binding() {
    Observable.just(())
      .bind(to: fetchShopListObserver)
      .disposed(by: disposeBag)
  }
}

extension HomeViewModel: HomeViewModelType {
  public var input: HomeViewModelInputType {
    return self
  }

  public var output: HomeViewModelOutputType {
    return self
  }
}

extension HomeViewModel: HomeViewModelInputType {
  public var shopListRequest: AnyObserver<Void> {
    return fetchShopListObserver.asObserver()
  }
}

extension HomeViewModel: HomeViewModelOutputType {
  public var shopListResult: Observable<String> {
    return shopListResultObserver.asObservable()
  }
}
