//
//  HomeViewController.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Design
import Domain
import RxSwift
import UIKit

final class HomeViewController: RickViewController {
//    @IBOutlet private weak var registerButton: ContainedButton!

  private let viewModel: HomeViewModelType

  // MARK: - Initialization

  @available(*, unavailable)
  public required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public init(viewModel: HomeViewModelType,
              navigationViewModel: NavigationViewModelType)
  {
    self.viewModel = viewModel
    super.init(navigationViewModel: navigationViewModel)
  }

  override public func viewDidLoad() {
    super.viewDidLoad()
    bindInput(viewModel.input)
    bindOutput(viewModel.output)
  }

  private func bindInput(_ input: HomeViewModelInputType) {
    Observable.just(())
      .bind(to: input.shopListRequest)
      .disposed(by: disposeBag)
  }

  private func bindOutput(_ output: HomeViewModelOutputType) {
    output.shopListResult
      .subscribe { message in
        print(message)
      }
      .disposed(by: disposeBag)
  }
}
