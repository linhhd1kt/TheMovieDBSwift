//
//  FontConfigurator.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Foundation
import UIKit

public enum Resources {
  public struct Fonts {}
}

public extension Resources.Fonts {
  enum Weight: String {
    case thin = "NotoSans-Thin"
    case ultraLight = "NotoSans-ExtraLight"
    case light = "NotoSans-Light"
    case regular = "NotoSans-Regular"
    case medium = "NotoSans-Medium"
    case semibold = "NotoSans-SemiBold"
    case bold = "NotoSans-Bold"
    case heavy = "NotoSans-ExtraBold"
    case black = "NotoSans-Black"
    case italic = "NotoSans-Italic"
  }
}

public extension UIFontDescriptor.AttributeName {
  static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

public extension UIFont {
  @objc class func mySystemFont(ofSize: CGFloat, weight: UIFont.Weight) -> UIFont {
    var fontName: Resources.Fonts.Weight
    switch weight {
    case .thin: fontName = .thin
    case .ultraLight: fontName = .ultraLight
    case .light: fontName = .light
    case .regular: fontName = .regular
    case .medium: fontName = .medium
    case .semibold: fontName = .semibold
    case .bold: fontName = .bold
    case .heavy: fontName = .heavy
    case .black: fontName = .black
    default: fontName = .regular
    }
    return UIFont(name: fontName.rawValue, size: ofSize) ?? systemFont(ofSize: ofSize)
  }

  @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
    return UIFont(name: Resources.Fonts.Weight.light.rawValue, size: size)
      ?? .systemFont(ofSize: size)
  }

  @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
    return UIFont(name: Resources.Fonts.Weight.bold.rawValue, size: size)
      ?? .systemFont(ofSize: size)
  }

  @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
    return UIFont(name: Resources.Fonts.Weight.italic.rawValue, size: size)
      ?? .systemFont(ofSize: size)
  }

  @objc convenience init?(myCoder aDecoder: NSCoder) {
    guard
      let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
      let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String
    else {
      self.init(myCoder: aDecoder)
      return
    }
    var fontName = ""
    switch fontAttribute {
    case "CTFontRegularUsage":
      fontName = Resources.Fonts.Weight.regular.rawValue
    case "CTFontMediumUsage":
      fontName = Resources.Fonts.Weight.medium.rawValue
    case "CTFontEmphasizedUsage":
      fontName = Resources.Fonts.Weight.regular.rawValue
    case "CTFontBoldUsage":
      fontName = Resources.Fonts.Weight.bold.rawValue
    case "CTFontSemiboldUsage":
      fontName = Resources.Fonts.Weight.semibold.rawValue
    case "CTFontHeavyUsage":
      fontName = Resources.Fonts.Weight.heavy.rawValue
    case"CTFontBlackUsage":
      fontName = Resources.Fonts.Weight.black.rawValue
    case "CTFontObliqueUsage":
      fontName = Resources.Fonts.Weight.italic.rawValue
    default:
      fontName = Resources.Fonts.Weight.regular.rawValue
    }
    self.init(name: fontName, size: fontDescriptor.pointSize)
  }

  class func overrideDefaultTypography() {
    guard self == UIFont.self else {
      return
    }

    if let systemFontMethodWithWeight = class_getClassMethod(self, #selector(systemFont(ofSize: weight:))),
       let mySystemFontMethodWithWeight = class_getClassMethod(self, #selector(mySystemFont(ofSize: weight:))) {
      method_exchangeImplementations(systemFontMethodWithWeight, mySystemFontMethodWithWeight)
    }

    if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
       let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
      method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
    }

    if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
       let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
      method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
    }

    if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
       let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:))) {
      method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
    }

    if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))),
       let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
      method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
    }
  }
}

extension UIFont {
  static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) -> Bool {
    guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension) else {
      fatalError("Couldn't find font \(fontName)")
    }

    guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
      fatalError("Couldn't load data from the font \(fontName)")
    }

    guard let font = CGFont(fontDataProvider) else {
      fatalError("Couldn't create font from data")
    }

    var error: Unmanaged<CFError>?
    let success = CTFontManagerRegisterGraphicsFont(font, &error)
    guard success else {
      print("Error registering font: maybe it was already registered.")
      return false
    }

    return true
  }
}
