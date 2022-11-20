//
//  Button.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 18/11/2022.
//

import UIKit

final class Button: UIButton {
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
