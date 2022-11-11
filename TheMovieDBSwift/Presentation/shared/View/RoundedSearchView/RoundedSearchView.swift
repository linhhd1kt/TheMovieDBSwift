//
//  RoundedSearchView.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 30/10/2022.
//

import UIKit

class RoundedSearchView: UIView {
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var roundedView: UIView!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchButton: UIButton!

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
        let connerRadius = self.height / 2
        roundedView.cornerRadius = connerRadius
        searchButton.cornerRadius = connerRadius
    }
}
