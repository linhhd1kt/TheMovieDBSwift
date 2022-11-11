//
//  DrawerMenuCell.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 18/10/2022.
//

import UIKit

class DrawerMenuCell: UITableViewCell {
    @IBOutlet private weak var menuItemLabel: UILabel!

    func configure(model: DrawerMenuScreen) {
        self.selectionStyle = .none
        self.menuItemLabel.text = model.name
    }
}
