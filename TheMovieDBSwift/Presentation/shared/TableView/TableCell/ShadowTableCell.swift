//
//  ShadowTableCell.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 10/11/2022.
//

import UIKit

class ShadowTableCell: BaseTableCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var layerView: UIView!
    private var shawdowSetuped = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if shawdowSetuped == false {
            containerView.layer.cornerRadius = 8
            containerView.layer.masksToBounds = true

            layerView.layer.masksToBounds = false
            layerView.layer.shadowOffset = .init(width: 3, height: 3)
            layerView.layer.shadowColor = design.style.colors.shadow.cgColor
            layerView.layer.shadowOpacity = 0.7
            layerView.layer.shadowRadius = 4
            
            layerView.layer.shouldRasterize = true
            layerView.layer.rasterizationScale = UIScreen.main.scale
            shawdowSetuped = true
        }
        layerView.layer.shadowPath = UIBezierPath(roundedRect: layerView.bounds,
                                                  byRoundingCorners: .allCorners,
                                                  cornerRadii: CGSize(width: 8, height: 8)).cgPath
    }
}
