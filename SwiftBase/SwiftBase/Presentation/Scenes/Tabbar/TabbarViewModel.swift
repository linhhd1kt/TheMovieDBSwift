//
//  TabbarViewModel.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxCocoa
import RxSwift

public final class TabbarViewModel: BaseViewModel {
  override public init() {
    super.init()
    binding()
  }

  private func binding() {}
}

extension TabbarViewModel: TabbarViewModelType {
  public var input: TabbarViewModelInputType {
    return self
  }

  public var output: TabbarViewModelOutputType {
    return self
  }
}

extension TabbarViewModel: TabbarViewModelInputType {}

extension TabbarViewModel: TabbarViewModelOutputType {}
