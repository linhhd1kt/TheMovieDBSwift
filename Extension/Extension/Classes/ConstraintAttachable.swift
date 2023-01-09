//
//  AnchorsAttachable.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import UIKit

public protocol ConstraintAttachable {}

extension UIView: ConstraintAttachable {}

public extension ConstraintAttachable where Self: UIView {
  func attach(_ child: UIView) {
    child.translatesAutoresizingMaskIntoConstraints = false
    addSubview(child)
    NSLayoutConstraint.activate(
      [
        child.leadingAnchor.constraint(equalTo: leadingAnchor),
        child.trailingAnchor.constraint(equalTo: trailingAnchor),
        child.topAnchor.constraint(equalTo: topAnchor),
        child.bottomAnchor.constraint(equalTo: bottomAnchor)
      ]
    )
  }
}
