//
//  MovieCell.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import UIKit
import Domain

class MediaCollectionCell: ShadowCollectionCell {
  @IBOutlet private var posterImage: UIImageView!
  @IBOutlet private var voteView: CircleView!
  @IBOutlet private var movieTitleLabel: UILabel!
  @IBOutlet private var releaseDateLabel: UILabel!

  func configure(_ item: MediaItemType) {
    imageLoader.loadTMDBImage(with: item.posterPath, to: posterImage)
    movieTitleLabel.text = item.name
    releaseDateLabel.text = item.date
    voteView.createCircularPath(percentage: item.voteAverage)
    voteView.progressAnimation(duration: 2)
  }
}
