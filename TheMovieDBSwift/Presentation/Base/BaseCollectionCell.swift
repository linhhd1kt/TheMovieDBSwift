//
//  BaseCollectionCell.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 10/11/2022.
//

import UIKit

class BaseCollectionCell: UICollectionViewCell {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
    }
}
