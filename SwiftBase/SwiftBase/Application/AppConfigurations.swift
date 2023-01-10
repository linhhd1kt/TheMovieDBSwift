//
//  AppConfiguration.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Design
import Domain
import FontBlaster
import Foundation
import PopupDialog
import Services

public protocol AppConfigType {
  func configureAppearance()
  func configureLanguage()
}

public final class AppConfig: AppConfigType {
  private var design: DesignType {
    guard let design = ServiceFacade.getService(DesignType.self) else {
      fatalError("Design should be registered!")
    }
    return design
  }

  public init() { }
  
  public func configureAppearance() {
    configureDialog()
  }
  
  // prefer: https://github.com/Orderella/PopupDialog
  private func configureDialog() {
    // Dialog Default View Appearance Settings
    let dialogAppearance = PopupDialogDefaultView.appearance()
    dialogAppearance.backgroundColor = design.style.colors.surface
    dialogAppearance.titleFont = .boldSystemFont(ofSize: 14)
    dialogAppearance.titleColor = design.style.colors.primary
    dialogAppearance.titleTextAlignment = .center
    dialogAppearance.messageFont = .boldSystemFont(ofSize: 14)
    dialogAppearance.messageColor = design.style.colors.onSurfaceVariant
    dialogAppearance.messageTextAlignment = .center

    // Dialog Container Appearance Settings
    let containerAppearance = PopupDialogContainerView.appearance()
    containerAppearance.backgroundColor = design.style.colors.surface

    // Button Appearance Settings
    let overlayAppearance = PopupDialogOverlayView.appearance()
    overlayAppearance.color = design.style.colors.shadow
    overlayAppearance.blurRadius = 20
    overlayAppearance.blurEnabled = true
    overlayAppearance.liveBlurEnabled = false
    overlayAppearance.opacity = 0.7

    // Button Appearance Settings
    let buttonAppearance = DefaultButton.appearance()
    // Default button
    buttonAppearance.titleFont = .boldSystemFont(ofSize: 14)
    buttonAppearance.titleColor = design.style.colors.onSurface
    buttonAppearance.buttonColor = .clear
    buttonAppearance.separatorColor = design.style.colors.onSurfaceVariant
    // Cancel button
    CancelButton.appearance().titleColor = design.style.colors.onSurface
    // Destructive button
    DestructiveButton.appearance().titleColor = design.style.colors.onErrorContainer
  }

  public func configureLanguage() {
    // TODO: set en for debug, ja for build and run
    #if DEVELOPMENT
      let lang = "en"
    #else
      let lang = "ja"
    #endif
    let defaults = UserDefaults.standard
    defaults.set([lang], forKey: "AppleLanguages")
    defaults.synchronize()
    Bundle.setLanguage(lang)
  }
}

public extension Bundle {
  var appName: String { getInfo("CFBundleName") }
  var displayName: String { getInfo("CFBundleDisplayName") }
  var language: String { getInfo("CFBundleDevelopmentRegion") }
  var identifier: String { getInfo("CFBundleIdentifier") }
  var copyright: String { getInfo("NSHumanReadableCopyright").replacingOccurrences(of: "\\\\n", with: "\n") }

  var appBuild: String { getInfo("CFBundleVersion") }
  var appVersionLong: String { getInfo("CFBundleShortVersionString") }
  // public var appVersionShort: String { getInfo("CFBundleShortVersion") }

  fileprivate func getInfo(_ key: String) -> String {
    guard let info = infoDictionary?[key] as? String else {
      fatalError("\(key) should exsist!")
    }
    return info
  }
}
