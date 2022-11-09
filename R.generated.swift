//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `Launch Screen`.
    static let launchScreen = _R.storyboard.launchScreen()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Launch Screen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 12 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")
    /// Color `background`.
    static let background = Rswift.ColorResource(bundle: R.hostingBundle, name: "background")
    /// Color `on-background-variant`.
    static let onBackgroundVariant = Rswift.ColorResource(bundle: R.hostingBundle, name: "on-background-variant")
    /// Color `on-background`.
    static let onBackground = Rswift.ColorResource(bundle: R.hostingBundle, name: "on-background")
    /// Color `on-primary`.
    static let onPrimary = Rswift.ColorResource(bundle: R.hostingBundle, name: "on-primary")
    /// Color `on-secondary`.
    static let onSecondary = Rswift.ColorResource(bundle: R.hostingBundle, name: "on-secondary")
    /// Color `on-ternary`.
    static let onTernary = Rswift.ColorResource(bundle: R.hostingBundle, name: "on-ternary")
    /// Color `primary-variant`.
    static let primaryVariant = Rswift.ColorResource(bundle: R.hostingBundle, name: "primary-variant")
    /// Color `primary`.
    static let primary = Rswift.ColorResource(bundle: R.hostingBundle, name: "primary")
    /// Color `secondary-variant`.
    static let secondaryVariant = Rswift.ColorResource(bundle: R.hostingBundle, name: "secondary-variant")
    /// Color `secondary`.
    static let secondary = Rswift.ColorResource(bundle: R.hostingBundle, name: "secondary")
    /// Color `ternary`.
    static let ternary = Rswift.ColorResource(bundle: R.hostingBundle, name: "ternary")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "background", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func background(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.background, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "on-background", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func onBackground(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.onBackground, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "on-background-variant", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func onBackgroundVariant(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.onBackgroundVariant, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "on-primary", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func onPrimary(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.onPrimary, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "on-secondary", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func onSecondary(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.onSecondary, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "on-ternary", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func onTernary(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.onTernary, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "primary", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func primary(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.primary, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "primary-variant", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func primaryVariant(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.primaryVariant, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "secondary", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func secondary(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.secondary, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "secondary-variant", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func secondaryVariant(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.secondaryVariant, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "ternary", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func ternary(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.ternary, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "background", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func background(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.background.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "on-background", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func onBackground(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.onBackground.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "on-background-variant", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func onBackgroundVariant(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.onBackgroundVariant.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "on-primary", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func onPrimary(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.onPrimary.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "on-secondary", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func onSecondary(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.onSecondary.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "on-ternary", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func onTernary(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.onTernary.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "primary", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func primary(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.primary.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "primary-variant", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func primaryVariant(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.primaryVariant.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "secondary", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func secondary(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.secondary.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "secondary-variant", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func secondaryVariant(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.secondaryVariant.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "ternary", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func ternary(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.ternary.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.file` struct is generated, and contains static references to 1 files.
  struct file {
    /// Resource file `.swiftlint.yml`.
    static let swiftlintYml = Rswift.FileResource(bundle: R.hostingBundle, name: ".swiftlint", pathExtension: "yml")

    /// `bundle.url(forResource: ".swiftlint", withExtension: "yml")`
    static func swiftlintYml(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.swiftlintYml
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 4 images.
  struct image {
    /// Image `ic-logo`.
    static let icLogo = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic-logo")
    /// Image `ic-menu`.
    static let icMenu = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic-menu")
    /// Image `ic-profile`.
    static let icProfile = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic-profile")
    /// Image `ic-search`.
    static let icSearch = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic-search")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic-logo", bundle: ..., traitCollection: ...)`
    static func icLogo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icLogo, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic-menu", bundle: ..., traitCollection: ...)`
    static func icMenu(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icMenu, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic-profile", bundle: ..., traitCollection: ...)`
    static func icProfile(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icProfile, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic-search", bundle: ..., traitCollection: ...)`
    static func icSearch(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icSearch, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    struct uiApplicationSceneManifest {
      static let _key = "UIApplicationSceneManifest"
      static let uiApplicationSupportsMultipleScenes = false

      struct uiSceneConfigurations {
        static let _key = "UISceneConfigurations"

        struct uiWindowSceneSessionRoleApplication {
          struct `default` {
            static let _key = "default"
            static let uiSceneConfigurationName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "default"], key: "UISceneConfigurationName") ?? "default"
            static let uiSceneDelegateClassName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "default"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate"

            fileprivate init() {}
          }

          fileprivate init() {}
        }

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 8 nibs.
  struct nib {
    /// Nib `CircleView`.
    static let circleView = _R.nib._CircleView()
    /// Nib `DashboardViewController`.
    static let dashboardViewController = _R.nib._DashboardViewController()
    /// Nib `DrawerMenuCell`.
    static let drawerMenuCell = _R.nib._DrawerMenuCell()
    /// Nib `DrawerMenuViewController`.
    static let drawerMenuViewController = _R.nib._DrawerMenuViewController()
    /// Nib `LoginViewController`.
    static let loginViewController = _R.nib._LoginViewController()
    /// Nib `MovieCell`.
    static let movieCell = _R.nib._MovieCell()
    /// Nib `MovieListViewController`.
    static let movieListViewController = _R.nib._MovieListViewController()
    /// Nib `MovieTableCell`.
    static let movieTableCell = _R.nib._MovieTableCell()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "CircleView", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.circleView) instead")
    static func circleView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.circleView)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "DashboardViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.dashboardViewController) instead")
    static func dashboardViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.dashboardViewController)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "DrawerMenuCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.drawerMenuCell) instead")
    static func drawerMenuCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.drawerMenuCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "DrawerMenuViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.drawerMenuViewController) instead")
    static func drawerMenuViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.drawerMenuViewController)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "LoginViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.loginViewController) instead")
    static func loginViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.loginViewController)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "MovieCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.movieCell) instead")
    static func movieCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.movieCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "MovieListViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.movieListViewController) instead")
    static func movieListViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.movieListViewController)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "MovieTableCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.movieTableCell) instead")
    static func movieTableCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.movieTableCell)
    }
    #endif

    static func circleView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.circleView.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }

    static func dashboardViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.dashboardViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }

    static func drawerMenuCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> DrawerMenuCell? {
      return R.nib.drawerMenuCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? DrawerMenuCell
    }

    static func drawerMenuViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.drawerMenuViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }

    static func loginViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.loginViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }

    static func movieCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> MovieCell? {
      return R.nib.movieCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? MovieCell
    }

    static func movieListViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.movieListViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }

    static func movieTableCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> MovieTableCell? {
      return R.nib.movieTableCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? MovieTableCell
    }

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 8 localization keys.
    struct localizable {
      /// en translation: Error
      ///
      /// Locales: en, ja
      static let error = Rswift.StringResource(key: "error", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ja"], comment: nil)
      /// en translation: Failed loading movies
      ///
      /// Locales: en, ja
      static let failedLoadingMovies = Rswift.StringResource(key: "failed-loading-movies", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ja"], comment: nil)
      /// en translation: Movies
      ///
      /// Locales: en, ja
      static let movie = Rswift.StringResource(key: "movie", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ja"], comment: nil)
      /// en translation: No internet connection
      ///
      /// Locales: en, ja
      static let noInternetConnection = Rswift.StringResource(key: "no-internet-connection", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ja"], comment: nil)
      /// en translation: Release Date
      ///
      /// Locales: en, ja
      static let releaseDate = Rswift.StringResource(key: "release-date", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ja"], comment: nil)
      /// en translation: Search Movies
      ///
      /// Locales: en, ja
      static let searchMovies = Rswift.StringResource(key: "search-movies", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ja"], comment: nil)
      /// en translation: Search results
      ///
      /// Locales: en, ja
      static let searchResult = Rswift.StringResource(key: "search-result", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ja"], comment: nil)
      /// en translation: To be announced
      ///
      /// Locales: en, ja
      static let toBeAnnounced = Rswift.StringResource(key: "to-be-announced", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ja"], comment: nil)

      /// en translation: Error
      ///
      /// Locales: en, ja
      static func error(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("error", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "error"
        }

        return NSLocalizedString("error", bundle: bundle, comment: "")
      }

      /// en translation: Failed loading movies
      ///
      /// Locales: en, ja
      static func failedLoadingMovies(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("failed-loading-movies", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "failed-loading-movies"
        }

        return NSLocalizedString("failed-loading-movies", bundle: bundle, comment: "")
      }

      /// en translation: Movies
      ///
      /// Locales: en, ja
      static func movie(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("movie", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "movie"
        }

        return NSLocalizedString("movie", bundle: bundle, comment: "")
      }

      /// en translation: No internet connection
      ///
      /// Locales: en, ja
      static func noInternetConnection(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("no-internet-connection", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "no-internet-connection"
        }

        return NSLocalizedString("no-internet-connection", bundle: bundle, comment: "")
      }

      /// en translation: Release Date
      ///
      /// Locales: en, ja
      static func releaseDate(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("release-date", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "release-date"
        }

        return NSLocalizedString("release-date", bundle: bundle, comment: "")
      }

      /// en translation: Search Movies
      ///
      /// Locales: en, ja
      static func searchMovies(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("search-movies", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "search-movies"
        }

        return NSLocalizedString("search-movies", bundle: bundle, comment: "")
      }

      /// en translation: Search results
      ///
      /// Locales: en, ja
      static func searchResult(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("search-result", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "search-result"
        }

        return NSLocalizedString("search-result", bundle: bundle, comment: "")
      }

      /// en translation: To be announced
      ///
      /// Locales: en, ja
      static func toBeAnnounced(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("to-be-announced", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "to-be-announced"
        }

        return NSLocalizedString("to-be-announced", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib {
    struct _CircleView: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "CircleView"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }

      fileprivate init() {}
    }

    struct _DashboardViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "DashboardViewController"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }

      fileprivate init() {}
    }

    struct _DrawerMenuCell: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "DrawerMenuCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> DrawerMenuCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? DrawerMenuCell
      }

      fileprivate init() {}
    }

    struct _DrawerMenuViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "DrawerMenuViewController"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }

      fileprivate init() {}
    }

    struct _LoginViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "LoginViewController"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }

      fileprivate init() {}
    }

    struct _MovieCell: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "MovieCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> MovieCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? MovieCell
      }

      fileprivate init() {}
    }

    struct _MovieListViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "MovieListViewController"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }

      fileprivate init() {}
    }

    struct _MovieTableCell: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "MovieTableCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> MovieTableCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? MovieTableCell
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "Launch Screen"

      static func validate() throws {
        if UIKit.UIImage(named: "ic-logo", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic-logo' is used in storyboard 'Launch Screen', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "primary", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'primary' is used in storyboard 'Launch Screen', but couldn't be loaded.") }
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
