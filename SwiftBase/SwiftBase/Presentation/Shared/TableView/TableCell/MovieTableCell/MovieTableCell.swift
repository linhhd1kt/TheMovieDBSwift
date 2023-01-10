//
//  MovieTableCell.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Services
import Domain

final class MovieTableCell: ShadowTableCell {
  @IBOutlet private var backdropImageView: UIImageView!
  @IBOutlet private var titleLabel: UILabel!
  @IBOutlet private var releaseDateLabel: UILabel!
  @IBOutlet private var overviewLabel: UILabel!
  
  func configure(_ item: MediaItemType) {
    imageLoader.loadTMDBImage(with: item.posterPath, to: backdropImageView)
    titleLabel.text = item.name
    releaseDateLabel.text = item.date
    overviewLabel.text = item.overview
  }
}
