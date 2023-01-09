//
//  ExtendedFABButton.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift

public class ExtendedFABButton: UIView {
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
    button.setBackgroundImage(design.style.colors.secondary.image, for: .normal)
    button.setBackgroundImage(design.style.colors.secondaryContainer.image, for: .disabled)
  }

  private func binding() {}
}

extension ExtendedFABButton: HasDeSign {}

public extension Reactive where Base: ExtendedFABButton {
  var tap: Observable<Void> {
    return base.button.rx.tap.asObservable()
  }

  var enabled: Binder<Bool> {
    return base.button.rx.isEnabled
  }
}
