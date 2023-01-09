//
//  ElevatedButton.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift
import Extension

public class ElevatedButton: UIView {
  @IBOutlet fileprivate var contentView: UIView!
  @IBOutlet fileprivate var button: UIButton!

  @IBInspectable public var localizedText: String = "" {
    didSet {
      button.setAttributedTitle(NSAttributedString(string: NSLocalizedString(localizedText, comment: localizedText)), for: .normal)
    }
  }

  internal var shapFamily: ShapFamily {
    return .rounded
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
    binding()
  }

  func configureLayouts() {
    backgroundColor = .clear
    button.setBackgroundImage(design.style.colors.inversePrimary.image, for: .disabled)
    button.setBackgroundImage(design.style.colors.primary.image, for: .normal)
  }

  private func binding() {}

  override public func layoutSubviews() {
    super.layoutSubviews()
    if button.cornerRadius != bounds.height / 2 {
      button.cornerRadius = bounds.height / 2
    }
  }
}

extension ElevatedButton: HasDeSign {}

public extension Reactive where Base: ElevatedButton {
  var tap: Observable<Void> {
    return base.button.rx.tap.asObservable()
  }

  var enabled: Binder<Bool> {
    return base.button.rx.isEnabled
  }
}
