//
//  BaseTableCell.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 10/11/2022.
//

import UIKit

class BaseTableCell: UITableViewCell {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    private func setup() {
        selectionStyle = .none
    }
}
