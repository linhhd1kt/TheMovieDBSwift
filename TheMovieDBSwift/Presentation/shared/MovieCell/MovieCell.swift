//
//  MovieCell.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 30/10/2022.
//

import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var voteView: CircleView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    
    func configure(_ model: Movie) {
        imageLoader.loadTMDBImage(with: model.posterPath, to: posterImage)
        movieTitleLabel.text = model.title
        releaseDateLabel.text = model.releaseDate
        voteView.createCircularPath(percentage: model.voteAverage)
        voteView.progressAnimation(duration: 2)
    }
}
