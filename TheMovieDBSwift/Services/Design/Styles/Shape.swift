//
//  Shape.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 18/11/2022.
//

enum ShapFamily {
    case rounded
    case cut
}

typealias ShapScaleValue = (Float, Float, Float, Float)

protocol ShapScaleType {
    var noRounding: ShapScaleValue { get }
    var extraSmall: ShapScaleValue { get }
    var extraSmallTop: ShapScaleValue { get }
    var small: ShapScaleValue { get }
    var medium: ShapScaleValue { get }
    var large: ShapScaleValue { get }
    var largeEnd: ShapScaleValue { get }
    var largeTop: ShapScaleValue { get }
    var extraLargeTop: ShapScaleValue { get }
    var full: ShapScaleValue { get }
}

struct DefaultShapScale: ShapScaleType {
    let noRounding: ShapScaleValue = (0, 0, 0, 0)
    let extraSmall: ShapScaleValue = (4, 4, 4, 4)
    let extraSmallTop: ShapScaleValue = (4, 4, 0, 0)
    let small: ShapScaleValue = (8, 8, 8, 8)
    let medium: ShapScaleValue = (12, 12, 12, 12)
    let large: ShapScaleValue = (16, 16, 16, 16)
    let largeEnd: ShapScaleValue = (0, 16, 16, 0)
    let largeTop: ShapScaleValue = (16, 16, 0, 0)
    let extraLargeTop: ShapScaleValue = (28, 28, 28, 28)
    let full: ShapScaleValue = (56, 56, 56, 56)
}

protocol ShapType {
    var family: ShapFamily { get }
    var scale: ShapScaleType { get }
}

struct DefaultShap: ShapType {
    let family: ShapFamily = .rounded
    let scale: ShapScaleType = DefaultShapScale()
}
