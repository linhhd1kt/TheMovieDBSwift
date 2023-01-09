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
  public static let black = ColorAsset(name: "black")
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
  public static let onTertiaryContainer = ColorAsset(name: "on-tertiary-container")
  public static let onTertiary = ColorAsset(name: "on-tertiary")
  public static let outline = ColorAsset(name: "outline")
  public static let primaryContainer = ColorAsset(name: "primary-container")
  public static let primary = ColorAsset(name: "primary")
  public static let secondaryContainer = ColorAsset(name: "secondary-container")
  public static let secondary = ColorAsset(name: "secondary")
  public static let shadow = ColorAsset(name: "shadow")
  public static let surfaceTintColor = ColorAsset(name: "surface-tint-color")
  public static let surfaceTint = ColorAsset(name: "surface-tint")
  public static let surfaceVariant = ColorAsset(name: "surface-variant")
  public static let surface = ColorAsset(name: "surface")
  public static let tertiaryContainer = ColorAsset(name: "tertiary-container")
  public static let tertiary = ColorAsset(name: "tertiary")
  public static let error0 = ColorAsset(name: "error0")
  public static let error10 = ColorAsset(name: "error10")
  public static let error100 = ColorAsset(name: "error100")
  public static let error15 = ColorAsset(name: "error15")
  public static let error20 = ColorAsset(name: "error20")
  public static let error25 = ColorAsset(name: "error25")
  public static let error30 = ColorAsset(name: "error30")
  public static let error35 = ColorAsset(name: "error35")
  public static let error40 = ColorAsset(name: "error40")
  public static let error5 = ColorAsset(name: "error5")
  public static let error50 = ColorAsset(name: "error50")
  public static let error60 = ColorAsset(name: "error60")
  public static let error70 = ColorAsset(name: "error70")
  public static let error80 = ColorAsset(name: "error80")
  public static let error90 = ColorAsset(name: "error90")
  public static let error95 = ColorAsset(name: "error95")
  public static let error98 = ColorAsset(name: "error98")
  public static let error99 = ColorAsset(name: "error99")
  public static let neutral0 = ColorAsset(name: "neutral0")
  public static let neutral10 = ColorAsset(name: "neutral10")
  public static let neutral100 = ColorAsset(name: "neutral100")
  public static let neutral15 = ColorAsset(name: "neutral15")
  public static let neutral20 = ColorAsset(name: "neutral20")
  public static let neutral25 = ColorAsset(name: "neutral25")
  public static let neutral30 = ColorAsset(name: "neutral30")
  public static let neutral35 = ColorAsset(name: "neutral35")
  public static let neutral40 = ColorAsset(name: "neutral40")
  public static let neutral5 = ColorAsset(name: "neutral5")
  public static let neutral50 = ColorAsset(name: "neutral50")
  public static let neutral60 = ColorAsset(name: "neutral60")
  public static let neutral70 = ColorAsset(name: "neutral70")
  public static let neutral80 = ColorAsset(name: "neutral80")
  public static let neutral90 = ColorAsset(name: "neutral90")
  public static let neutral95 = ColorAsset(name: "neutral95")
  public static let neutral98 = ColorAsset(name: "neutral98")
  public static let neutral99 = ColorAsset(name: "neutral99")
  public static let neutralNaN = ColorAsset(name: "neutralNaN")
  public static let neutralVariant0 = ColorAsset(name: "neutral-variant0")
  public static let neutralVariant10 = ColorAsset(name: "neutral-variant10")
  public static let neutralVariant100 = ColorAsset(name: "neutral-variant100")
  public static let neutralVariant15 = ColorAsset(name: "neutral-variant15")
  public static let neutralVariant20 = ColorAsset(name: "neutral-variant20")
  public static let neutralVariant25 = ColorAsset(name: "neutral-variant25")
  public static let neutralVariant30 = ColorAsset(name: "neutral-variant30")
  public static let neutralVariant35 = ColorAsset(name: "neutral-variant35")
  public static let neutralVariant40 = ColorAsset(name: "neutral-variant40")
  public static let neutralVariant5 = ColorAsset(name: "neutral-variant5")
  public static let neutralVariant50 = ColorAsset(name: "neutral-variant50")
  public static let neutralVariant60 = ColorAsset(name: "neutral-variant60")
  public static let neutralVariant70 = ColorAsset(name: "neutral-variant70")
  public static let neutralVariant80 = ColorAsset(name: "neutral-variant80")
  public static let neutralVariant90 = ColorAsset(name: "neutral-variant90")
  public static let neutralVariant95 = ColorAsset(name: "neutral-variant95")
  public static let neutralVariant98 = ColorAsset(name: "neutral-variant98")
  public static let neutralVariant99 = ColorAsset(name: "neutral-variant99")
  public static let primary0 = ColorAsset(name: "primary0")
  public static let primary10 = ColorAsset(name: "primary10")
  public static let primary100 = ColorAsset(name: "primary100")
  public static let primary15 = ColorAsset(name: "primary15")
  public static let primary20 = ColorAsset(name: "primary20")
  public static let primary25 = ColorAsset(name: "primary25")
  public static let primary30 = ColorAsset(name: "primary30")
  public static let primary35 = ColorAsset(name: "primary35")
  public static let primary40 = ColorAsset(name: "primary40")
  public static let primary5 = ColorAsset(name: "primary5")
  public static let primary50 = ColorAsset(name: "primary50")
  public static let primary60 = ColorAsset(name: "primary60")
  public static let primary70 = ColorAsset(name: "primary70")
  public static let primary80 = ColorAsset(name: "primary80")
  public static let primary90 = ColorAsset(name: "primary90")
  public static let primary95 = ColorAsset(name: "primary95")
  public static let primary98 = ColorAsset(name: "primary98")
  public static let primary99 = ColorAsset(name: "primary99")
  public static let secondary0 = ColorAsset(name: "secondary0")
  public static let secondary10 = ColorAsset(name: "secondary10")
  public static let secondary100 = ColorAsset(name: "secondary100")
  public static let secondary15 = ColorAsset(name: "secondary15")
  public static let secondary20 = ColorAsset(name: "secondary20")
  public static let secondary25 = ColorAsset(name: "secondary25")
  public static let secondary30 = ColorAsset(name: "secondary30")
  public static let secondary35 = ColorAsset(name: "secondary35")
  public static let secondary40 = ColorAsset(name: "secondary40")
  public static let secondary5 = ColorAsset(name: "secondary5")
  public static let secondary50 = ColorAsset(name: "secondary50")
  public static let secondary60 = ColorAsset(name: "secondary60")
  public static let secondary70 = ColorAsset(name: "secondary70")
  public static let secondary80 = ColorAsset(name: "secondary80")
  public static let secondary90 = ColorAsset(name: "secondary90")
  public static let secondary95 = ColorAsset(name: "secondary95")
  public static let secondary98 = ColorAsset(name: "secondary98")
  public static let secondary99 = ColorAsset(name: "secondary99")
  public static let tertiary0 = ColorAsset(name: "tertiary0")
  public static let tertiary10 = ColorAsset(name: "tertiary10")
  public static let tertiary100 = ColorAsset(name: "tertiary100")
  public static let tertiary15 = ColorAsset(name: "tertiary15")
  public static let tertiary20 = ColorAsset(name: "tertiary20")
  public static let tertiary25 = ColorAsset(name: "tertiary25")
  public static let tertiary30 = ColorAsset(name: "tertiary30")
  public static let tertiary35 = ColorAsset(name: "tertiary35")
  public static let tertiary40 = ColorAsset(name: "tertiary40")
  public static let tertiary5 = ColorAsset(name: "tertiary5")
  public static let tertiary50 = ColorAsset(name: "tertiary50")
  public static let tertiary60 = ColorAsset(name: "tertiary60")
  public static let tertiary70 = ColorAsset(name: "tertiary70")
  public static let tertiary80 = ColorAsset(name: "tertiary80")
  public static let tertiary90 = ColorAsset(name: "tertiary90")
  public static let tertiary95 = ColorAsset(name: "tertiary95")
  public static let tertiary98 = ColorAsset(name: "tertiary98")
  public static let tertiary99 = ColorAsset(name: "tertiary99")
  public static let surface1 = ColorAsset(name: "surface1")
  public static let surface2 = ColorAsset(name: "surface2")
  public static let surface3 = ColorAsset(name: "surface3")
  public static let surface4 = ColorAsset(name: "surface4")
  public static let surface5 = ColorAsset(name: "surface5")
  public static let white = ColorAsset(name: "white")
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
