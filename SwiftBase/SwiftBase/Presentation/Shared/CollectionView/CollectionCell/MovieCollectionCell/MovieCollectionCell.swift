//
//  MovieCell.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import UIKit
import Domain

class MovieCollectionCell: ShadowCollectionCell {
  @IBOutlet private var posterImage: UIImageView!
  @IBOutlet private var voteView: CircleView!
  @IBOutlet private var movieTitleLabel: UILabel!
  @IBOutlet private var releaseDateLabel: UILabel!

  func configure(_ model: Movie) {
    imageLoader.loadTMDBImage(with: model.posterPath, to: posterImage)
    movieTitleLabel.text = model.title
    releaseDateLabel.text = model.releaseDate
    voteView.createCircularPath(percentage: model.voteAverage)
    voteView.progressAnimation(duration: 2)
  }
}
