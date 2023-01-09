// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Colors {
  public static let background = ColorAsset(name: "background")
  public static let errorContainer = ColorAsset(name: "error-container")
  public static let error = ColorAsset(name: "error")
  public static let inverseOnSurface = ColorAsset(name: "inverse-on-surface")
  public static let inversePrimary = ColorAsset(name: "inverse-primary")
  public static let inverseSurface = ColorAsset(name: "inverse-surface")
  public static let onBackground = ColorAsset(name: "on-background")
  public static let onErrorContainer = ColorAsset(name: "on-error-container")
  public static let onError = ColorAsset(name: "on-error")
  public static let onPrimaryContainer = ColorAsset(name: "on-primary-container")
  public static let onPrimary = ColorAsset(name: "on-primary")
  public static let onSecondaryContainer = ColorAsset(name: "on-secondary-container")
  public static let onSecondary = ColorAsset(name: "on-secondary")
  public static let onSurfaceVariant = ColorAsset(name: "on-surface-variant")
  public static let onSurface = ColorAsset(name: "on-surface")
  public static let onTernaryContainer = ColorAsset(name: "on-ternary-container")
  public static let onTernary = ColorAsset(name: "on-ternary")
  public static let outline = ColorAsset(name: "outline")
  public static let primaryContainer = ColorAsset(name: "primary-container")
  public static let primary = ColorAsset(name: "primary")
  public static let secondaryContainer = ColorAsset(name: "secondary-container")
  public static let secondary = ColorAsset(name: "secondary")
  public static let shadow = ColorAsset(name: "shadow")
  public static let surfaceTint = ColorAsset(name: "surface-tint")
  public static let surfaceVariant = ColorAsset(name: "surface-variant")
  public static let surface = ColorAsset(name: "surface")
  public static let ternaryContainer = ColorAsset(name: "ternary-container")
  public static let ternary = ColorAsset(name: "ternary")
}

// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
    public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
    public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
    @available(iOS 11.0, tvOS 11.0, *)
    public func color(compatibleWith traitCollection: UITraitCollection) -> Color {
      let bundle = BundleToken.bundle
      guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
        fatalError("Unable to load color asset named \(name).")
      }
      return color
    }
  #endif

  #if canImport(SwiftUI)
    @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
    public private(set) lazy var swiftUIColor: SwiftUI.Color = .init(asset: self)
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
      self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
      self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
      self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public extension SwiftUI.Color {
    init(asset: ColorAsset) {
      let bundle = BundleToken.bundle
      self.init(asset.name, bundle: bundle)
    }
  }
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
      return Bundle.module
    #else
      return Bundle(for: BundleToken.self)
    #endif
  }()
}

// swiftlint:enable convenience_type
