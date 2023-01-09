//
//  Color.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import UIKit

// references: using figma tool for generate theme and color assets
// material design theme generator:  https://www.figma.com/file/hCXAN6ODhsLcWf0C66npk9/Material-Theme-Builder-(Community)?node-id=0%3A1&t=4Pw3ohsEFrmwFtG2-0
// color assets generator: https://www.figma.com/file/Zpzv9EFEFenLowiXtQprqG/Xcode-color-asset-exporter-(Community)?node-id=0%3A1&t=DQQjdMdQ5ArdXjyc-0
// then using swiftgen to generate swift declaration from color assets

public protocol ColorSystemType {
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
  var shadow: UIColor { get }
}

public struct LightColor: ColorSystemType {
  // primary
  public let primary: UIColor = Colors.primary.color
  public let onPrimary = Colors.onPrimary.color
  public let primaryContainer = Colors.primaryContainer.color
  public let onPrimaryContainer = Colors.onPrimaryContainer.color
  public let inversePrimary = Colors.inversePrimary.color
  // secondary
  public let secondary = Colors.secondary.color
  public let onSecondary = Colors.onSecondary.color
  public let secondaryContainer = Colors.secondaryContainer.color
  public let onSecondaryContainer = Colors.onSecondaryContainer.color
  // tertiary
  public let tertiary = Colors.tertiary.color
  public let onTertiary = Colors.onTertiary.color
  public let tertiaryContainer = Colors.tertiaryContainer.color
  public let onTertiaryContainer = Colors.onTertiaryContainer.color
  // error:
  public let error = Colors.error.color
  public let onError = Colors.onError.color
  public let errorContainer = Colors.errorContainer.color
  public let onErrorContainer = Colors.onErrorContainer.color
  // neutral
  public let background = Colors.background.color
  public let onBackground = Colors.onBackground.color
  public let surface = Colors.surface.color
  public let inverseSurface = Colors.inverseSurface.color
  public let onSurface = Colors.onSurface.color
  public let inverseOnSurface = Colors.inverseOnSurface.color
  // neutral variant
  public let surfaceVariant = Colors.surfaceVariant.color
  public let onSurfaceVariant = Colors.onSurfaceVariant.color
  public let surfaceTint = Colors.surfaceTint.color
  // others
  public let outline = Colors.outline.color
  public let shadow = Colors.shadow.color
}
