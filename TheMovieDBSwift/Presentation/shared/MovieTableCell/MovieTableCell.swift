//
//  MovieTableCell.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import UIKit

class MovieTableCell: ShadowCell {
    @IBOutlet private weak var backdropImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    
    func configure(_ movie: Movie) {
        selectionStyle = .none
        imageLoader.loadTMDBImage(with: movie.posterPath, to: backdropImageView)
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        overviewLabel.text = movie.overview
    }
}

extension MovieTableCell: HasImageLoader { }
