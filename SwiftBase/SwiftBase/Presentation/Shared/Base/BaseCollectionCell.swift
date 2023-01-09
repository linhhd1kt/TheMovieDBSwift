//
//  BaseCollectionCell.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Design
import UIKit
import Services

class BaseCollectionCell: UICollectionViewCell {
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

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  private func setup() {}
}

extension BaseCollectionCell: HasDeSign {}
