//
//  OutlinedButton.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift

public class OutlinedButton: UIView {
  @IBOutlet fileprivate var contentView: UIView!
  @IBOutlet fileprivate var button: UIButton!

  @IBInspectable public var localizedText: String = "" {
    didSet {
      button.setAttributedTitle(NSAttributedString(string: NSLocalizedString(localizedText, comment: localizedText)), for: .normal)
    }
  }

  // MARK: - Output

  fileprivate let tapObserver = PublishSubject<Void>()

  override public init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }

  func setup() {
    loadFromXib(moduleName: self.moduleName)
    configureLayouts()
  }

  func configureLayouts() {
    backgroundColor = .clear
  }

  override public func layoutSubviews() {
    super.layoutSubviews()
    if button.cornerRadius != bounds.height / 2 {
      button.cornerRadius = bounds.height / 2
      button.borderColor = Colors.primary.color
      button.borderWidth = 1
    }
  }

  private func binding() {}
}

extension OutlinedButton: HasDeSign {}

public extension Reactive where Base: OutlinedButton {
  var tap: Observable<Void> {
    return base.button.rx.tap.asObservable()
  }

  var enabled: Binder<Bool> {
    return base.button.rx.isEnabled
  }
}
