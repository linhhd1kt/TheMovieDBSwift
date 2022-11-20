//
//  Theme.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 18/11/2022.
//

import UIKit

// https://www.figma.com/community/file/1035203688168086460
// https://github.com/material-foundation/material-color-utilities
// https://www.figma.com/community/plugin/1034969338659738588/Material-Theme-Builder
// https://m3.material.io/theme-builder#/custom
protocol StyleType {
    var colors: ColorSystemType { get }
    var icons: IconsType { get }
    var elvation: ElevationType { get }
    var shap: ShapType { get }
    var easing: EasingType { get }
    var duration: DurationType { get }
    var symmetry: SymmetryType { get }
}

struct LightStyle: StyleType {
    let colors: ColorSystemType = LightColor()
    let icons: IconsType = LightIcons()
    let elvation: ElevationType = DefaultElevation()
    let shap: ShapType = DefaultShap()
    let easing: EasingType = DefaultEasing()
    let duration: DurationType = DefaultDuration()
    let symmetry: SymmetryType = .extraLargeTop
}
