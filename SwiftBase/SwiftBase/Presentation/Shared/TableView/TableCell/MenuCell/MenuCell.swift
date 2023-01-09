//
//  MenuCell.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import UIKit

class MenuCell: UITableViewCell {
  @IBOutlet private var menuItemLabel: UILabel!
  func configure(name: String) {
    selectionStyle = .none
    menuItemLabel.text = name
  }
}
