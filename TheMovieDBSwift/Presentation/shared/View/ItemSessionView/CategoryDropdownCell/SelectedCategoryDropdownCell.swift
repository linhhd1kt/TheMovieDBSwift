//
//  SelectedCategoryDropdownCell.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 11/11/2022.
//

import UIKit

class SelectedCategoryDropdownCell: UITableViewCell {
    @IBOutlet private weak var categoryNameLabel: UILabel!
    
    func configure(_ title: String) {
        categoryNameLabel.text = title
    }
}
