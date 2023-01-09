//
//  BaseTableCell.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Design
import UIKit
import Kingfisher
import Services

class BaseTableCell: UITableViewCell {
  var imageLoader: ImageLoaderType {
    guard let loader = ServiceFacade.getService(ImageLoaderType.self) else {
      fatalError("Image Loader should be implementation!")
    }
    return loader
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }

  private func setup() {
    selectionStyle = .none
  }
}

extension BaseTableCell: HasDeSign {}
