//
//  ImageLoader.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Kingfisher
import ObjectiveC
import RxSwift
import UIKit

public protocol ImageLoaderType {
  func loadImage(with urlString: String?, to imageView: UIImageView)
  func loadTMDBImage(with id: String?, to imageView: UIImageView)
}

public final class ImageLoader: ImageLoaderType {
  private let baseImageURL: URL

  public init(baseImageURL: URL) {
    self.baseImageURL = baseImageURL
  }
  
  public func loadImage(with urlString: String?, to imageView: UIImageView) {
    guard let urlString = urlString,
          let url = URL(string: urlString) else {
      return
    }
    self.loadImage(with: url, to: imageView)
  }
  
  public func loadTMDBImage(with id: String?, to imageView: UIImageView) {
    guard let id = id else {
      return
    }
    let url = self.baseImageURL.appendingPathComponent("t/p/w185").appendingPathComponent(id)
    self.loadImage(with: url, to: imageView)
  }
  
  private func loadImage(with url: URL, to imageView: UIImageView) {
    imageView.kf.indicatorType = .activity
    imageView.kf.setImage(
      with: url,
      placeholder: UIImage(systemName: "photo"),
      options: [
        .processor(DownsamplingImageProcessor(size: imageView.bounds.size)),
        .scaleFactor(UIScreen.main.scale),
        .cacheOriginalImage
      ])
  }
}
