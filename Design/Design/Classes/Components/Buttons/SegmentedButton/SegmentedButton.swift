//
//  SegmentedButton.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import UIKit
import RxCocoa
import RxSwift

public class SegmentedButton: UIView {
  @IBOutlet fileprivate var contentView: UIView!
  @IBOutlet fileprivate var segmentControl: UISegmentedControl!

  fileprivate let selectIndexObserver = PublishSubject<Int>()

  override public init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }

  internal func setup() {
    loadFromXib(moduleName: self.moduleName)
    configureLayouts()
  }

  func configureLayouts() {
    backgroundColor = .clear
  }
}

extension SegmentedButton: HasDeSign {}

public extension Reactive where Base: SegmentedButton {
  var text: Binder<Int> {
    return Binder(base) { view, index in
      view.segmentControl.selectedSegmentIndex = index
    }
  }

  var selectedIndex: ControlProperty<Int> {
    return base.segmentControl.rx.selectedSegmentIndex
  }
}
