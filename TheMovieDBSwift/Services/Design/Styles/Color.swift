//
//  Color.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 18/11/2022.
//

import UIKit

protocol ColorSystemType {
    // primary
    var primary: UIColor { get }
    var onPrimary: UIColor { get }
    var primaryContainer: UIColor { get }
    var onPrimaryContainer: UIColor { get }
    var inversePrimary: UIColor { get }
    // secondary
    var secondary: UIColor { get }
    var onSecondary: UIColor { get }
    var secondaryContainer: UIColor { get }
    var onSecondaryContainer: UIColor { get }
    // tertiary
    var tertiary: UIColor { get }
    var onTertiary: UIColor { get }
    var tertiaryContainer: UIColor { get }
    var onTertiaryContainer: UIColor { get }
    // error:
    var error: UIColor { get }
    var onError: UIColor { get }
    var errorContainer: UIColor { get }
    var onErrorContainer: UIColor { get }
    // neutral
    var background: UIColor { get }
    var onBackground: UIColor { get }
    var surface: UIColor { get }
    var inverseSurface: UIColor { get }
    var onSurface: UIColor { get }
    var inverseOnSurface: UIColor { get }
    // neutral variant
    var surfaceVariant: UIColor { get }
    var onSurfaceVariant: UIColor { get }
    var surfaceTint: UIColor { get }
    // others
    var outline: UIColor { get }
    var shadow: UIColor { get }}

struct LightColor: ColorSystemType {
    // primary
    let primary: UIColor = R.color.primary() ?? .clear
    let onPrimary = R.color.onPrimary() ?? .clear
    let primaryContainer = R.color.primaryContainer() ?? .clear
    let onPrimaryContainer = R.color.onPrimaryContainer() ?? .clear
    let inversePrimary = R.color.inversePrimary() ?? .clear
    // secondary
    let secondary = R.color.secondary() ?? .clear
    let onSecondary = R.color.onSecondary() ?? .clear
    let secondaryContainer = R.color.secondaryContainer() ?? .clear
    let onSecondaryContainer = R.color.onSecondaryContainer() ?? .clear
    // tertiary
    let tertiary = R.color.ternary() ?? .clear
    let onTertiary = R.color.onTernary() ?? .clear
    let tertiaryContainer = R.color.ternaryContainer() ?? .clear
    let onTertiaryContainer = R.color.onTernaryContainer() ?? .clear
    // error:
    let error = R.color.error() ?? .clear
    let onError = R.color.onError() ?? .clear
    let errorContainer = R.color.errorContainer() ?? .clear
    let onErrorContainer = R.color.onErrorContainer() ?? .clear
    // neutral
    let background = R.color.background() ?? .clear
    let onBackground = R.color.onBackground() ?? .clear
    let surface = R.color.surface() ?? .clear
    let inverseSurface = R.color.inverseSurface() ?? .clear
    let onSurface = R.color.onSurface() ?? .clear
    let inverseOnSurface = R.color.inverseOnSurface() ?? .clear
    // neutral variant
    let surfaceVariant = R.color.surfaceVariant() ?? .clear
    let onSurfaceVariant = R.color.onSurfaceVariant() ?? .clear
    let surfaceTint = R.color.surfaceTint() ?? .clear
    // others
    let outline = R.color.outline() ?? .clear
    let shadow = R.color.shadow() ?? .clear
}
