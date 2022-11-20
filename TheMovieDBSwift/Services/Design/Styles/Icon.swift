//
//  Icon.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 18/11/2022.
//

import UIKit

//https://fonts.google.com/icons?icon.category=Privacy%26Security

enum IconOpticalSize: Float {
    case tiny = 20.0
    case small = 24.0
    case medium = 40.0
    case large = 48.0
}

enum IconWeith {
    case x100
    case x200
    case x300
    case x400
    case x500
    case x600
    case x700
    case x800
    case x900
}

enum IconFill {
    case on
    case off
}

enum IconGrade {
    case dark
    case normal
    case emphasis
}

protocol IconType {
    var opticalSize: IconOpticalSize { get }
    var symbol: UIImage { get }
    var grade: IconGrade { get }
    var fill: IconFill { get }
}

struct Icon: IconType {
    let symbol: UIImage
    let opticalSize: IconOpticalSize
    let grade: IconGrade
    let fill: IconFill
    
    init(_ symbol: UIImage?,
         opticalSize: IconOpticalSize = .small,
         grade: IconGrade = .normal,
         fill: IconFill = .off) {
        self.symbol = symbol ?? .placeholder
        self.opticalSize = opticalSize
        self.grade = grade
        self.fill = fill
    }
}

protocol IconsType {
    var logo: IconType { get }
    var menu: IconType { get }
    var profile: IconType { get }
    var search: IconType { get }
}

struct LightIcons: IconsType {
    let logo: IconType = Icon(R.image.icLogo())
    let menu: IconType = Icon(R.image.icMenu())
    let profile: IconType = Icon(R.image.icProfile())
    let search: IconType = Icon(R.image.icSearch())
}
