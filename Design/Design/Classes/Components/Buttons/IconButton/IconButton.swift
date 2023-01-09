//
//  FABButton.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift

public class IconButton: UIView {
  @IBOutlet fileprivate var contentView: UIView!
  @IBOutlet fileprivate var button: UIButton!

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
    button.setBackgroundImage(design.style.colors.surface.image, for: .normal)
    button.setBackgroundImage(design.style.colors.surface.image, for: .disabled)
  }

  private func binding() {}
}

extension IconButton: HasDeSign {}

public extension Reactive where Base: IconButton {
  var tap: Observable<Void> {
    return base.button.rx.tap.asObservable()
  }

  var enabled: Binder<Bool> {
    return base.button.rx.isEnabled
  }
}
