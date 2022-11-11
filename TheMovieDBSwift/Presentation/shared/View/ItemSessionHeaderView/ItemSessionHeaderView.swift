//
//  ItemSessionHeaderView.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 30/10/2022.
//

import UIKit

class ItemSessionHeaderView: UIView {
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var sessionTitleLabel: UILabel!
    @IBOutlet private weak var dropdown: CategoryDropdown!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    private func setup() {
        loadFromXib()
        configureLayouts()
    }
    private func configureLayouts() {
    }
}
