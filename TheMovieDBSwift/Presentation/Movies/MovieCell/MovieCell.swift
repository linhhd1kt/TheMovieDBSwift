//
//  MovieCell.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    
    func configure(_ movie: Movie) {
        self.selectionStyle = .none
        self.nameLabel.text = movie.title
    }
}
