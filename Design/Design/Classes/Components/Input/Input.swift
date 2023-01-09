//
//  Button.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import UIKit
import RxSwift
import Extension

public class Input: UIView {
  @IBOutlet private var contentView: UIView!
  @IBOutlet private var textField: UITextField!

  // MARK: - Input

  public let inputTextObserver = PublishSubject<String?>()

  // MARK: - Output

  public let outputTextObserver = PublishSubject<String?>()

  override public init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }

  private func setup() {
    loadFromXib(moduleName: self.moduleName)
    configureLayouts()
    binding()
  }

  private func configureLayouts() {}

  private func binding() {
    inputTextObserver
      .bind(to: textField.rx.text)
      .disposed(by: disposeBag)
    textField.rx.text.asObservable()
      .bind(to: outputTextObserver)
      .disposed(by: disposeBag)
  }
}

extension Input: HasDisposeBag {}

public extension Reactive where Base: Input {
  var inputText: AnyObserver<String?> {
    return base.inputTextObserver.asObserver()
  }

  var outputText: Observable<String?> {
    return base.outputTextObserver.asObservable()
  }
}
