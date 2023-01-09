//
//  RoundedSearchView.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import UIKit

class RoundedSearchView: UIView {
  @IBOutlet private var contentView: UIView!
  @IBOutlet private var roundedView: UIView!
  @IBOutlet private var searchTextField: UITextField!
  @IBOutlet private var searchButton: UIButton!

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }

  private func setup() {
    loadFromXib()
    configureLayouts()
  }

  private func configureLayouts() {
    let connerRadius = height / 2
    roundedView.cornerRadius = connerRadius
    searchButton.cornerRadius = connerRadius
  }
}
