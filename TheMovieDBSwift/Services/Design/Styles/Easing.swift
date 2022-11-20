//
//  Easing.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 18/11/2022.
//

//https://m3.material.io/styles/motion/easing-and-duration/applying-easing-and-duration
//https://m3.material.io/styles/motion/easing-and-duration/tokens-specs

typealias EasingValue = (Float, Float, Float, Float)

protocol EasingType {
    var linear: EasingValue { get }
    var standard: EasingValue { get }
    var standardAccelerate: EasingValue { get }
    var standardDecelerate: EasingValue { get }
    var emphasized: EasingValue { get }
    var emphasizedDecelerate: EasingValue { get }
    var emphasizedAccelerate: EasingValue { get }
    var legacy: EasingValue { get }
    var legacyDecelerate: EasingValue { get }
    var legacyAccelerate: EasingValue { get }
}

struct DefaultEasing: EasingType {
    let linear: EasingValue = (0, 0, 1, 1)
    let standard: EasingValue = (0.2, 0, 0, 1)
    let standardAccelerate: EasingValue = (0.3, 0, 1, 1)
    let standardDecelerate: EasingValue = (0, 0, 0, 1)
    let emphasized: EasingValue = (0.2, 0, 0, 1)
    let emphasizedDecelerate: EasingValue = (0.05, 0.7, 0.1, 1)
    let emphasizedAccelerate: EasingValue = (0.3, 0, 0.8, 0.15)
    let legacy: EasingValue = (0.4, 0, 0.2, 1)
    let legacyDecelerate: EasingValue = (0.0, 0, 0.2, 1)
    let legacyAccelerate: EasingValue = (0.4, 0, 1.0, 1)
}
