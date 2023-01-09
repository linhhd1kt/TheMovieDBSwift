//
//  CategoryDropdownCell.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import UIKit

class CategoryDropdownCell: UITableViewCell {
  @IBOutlet private var categoryNameLabel: UILabel!

  func configure(_ title: String) {
    categoryNameLabel.text = title
  }
}
