//
//  AnchorsAttachable.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 16/11/2022.
//

import UIKit

protocol ConstraintAttachable { }

extension UIView: ConstraintAttachable { }

extension ConstraintAttachable where Self: UIView {
    func attach(_ child: UIView) {
        child.translatesAutoresizingMaskIntoConstraints = false
        addSubview(child)
        NSLayoutConstraint.activate(
            [
                child.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                child.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                child.topAnchor.constraint(equalTo: self.topAnchor),
                child.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ]
        )
    }
}
