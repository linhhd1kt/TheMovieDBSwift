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
  
  func configure(_ movie: Movie) {
    imageLoader.loadTMDBImage(with: movie.posterPath, to: backdropImageView)
    titleLabel.text = movie.title
    releaseDateLabel.text = movie.releaseDate
    overviewLabel.text = movie.overview
  }
}
