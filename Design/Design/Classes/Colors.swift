// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#001f24"></span>
  /// Alpha: 100% <br/> (0x001f24ff)
  internal static let mdThemeDarkBackground = ColorName(rgbaValue: 0x001F_24FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffb4ab"></span>
  /// Alpha: 100% <br/> (0xffb4abff)
  internal static let mdThemeDarkError = ColorName(rgbaValue: 0xFFB4_ABFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#93000a"></span>
  /// Alpha: 100% <br/> (0x93000aff)
  internal static let mdThemeDarkErrorContainer = ColorName(rgbaValue: 0x9300_0AFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#001f24"></span>
  /// Alpha: 100% <br/> (0x001f24ff)
  internal static let mdThemeDarkInverseOnSurface = ColorName(rgbaValue: 0x001F_24FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#2c59bc"></span>
  /// Alpha: 100% <br/> (0x2c59bcff)
  internal static let mdThemeDarkInversePrimary = ColorName(rgbaValue: 0x2C59_BCFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#97f0ff"></span>
  /// Alpha: 100% <br/> (0x97f0ffff)
  internal static let mdThemeDarkInverseSurface = ColorName(rgbaValue: 0x97F0_FFFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#97f0ff"></span>
  /// Alpha: 100% <br/> (0x97f0ffff)
  internal static let mdThemeDarkOnBackground = ColorName(rgbaValue: 0x97F0_FFFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#690005"></span>
  /// Alpha: 100% <br/> (0x690005ff)
  internal static let mdThemeDarkOnError = ColorName(rgbaValue: 0x6900_05FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffdad6"></span>
  /// Alpha: 100% <br/> (0xffdad6ff)
  internal static let mdThemeDarkOnErrorContainer = ColorName(rgbaValue: 0xFFDA_D6FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#002b74"></span>
  /// Alpha: 100% <br/> (0x002b74ff)
  internal static let mdThemeDarkOnPrimary = ColorName(rgbaValue: 0x002B_74FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#dae1ff"></span>
  /// Alpha: 100% <br/> (0xdae1ffff)
  internal static let mdThemeDarkOnPrimaryContainer = ColorName(rgbaValue: 0xDAE1_FFFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#003549"></span>
  /// Alpha: 100% <br/> (0x003549ff)
  internal static let mdThemeDarkOnSecondary = ColorName(rgbaValue: 0x0035_49FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#c3e8ff"></span>
  /// Alpha: 100% <br/> (0xc3e8ffff)
  internal static let mdThemeDarkOnSecondaryContainer = ColorName(rgbaValue: 0xC3E8_FFFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#97f0ff"></span>
  /// Alpha: 100% <br/> (0x97f0ffff)
  internal static let mdThemeDarkOnSurface = ColorName(rgbaValue: 0x97F0_FFFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#c5c6d0"></span>
  /// Alpha: 100% <br/> (0xc5c6d0ff)
  internal static let mdThemeDarkOnSurfaceVariant = ColorName(rgbaValue: 0xC5C6_D0FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#383100"></span>
  /// Alpha: 100% <br/> (0x383100ff)
  internal static let mdThemeDarkOnTertiary = ColorName(rgbaValue: 0x3831_00FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#fee300"></span>
  /// Alpha: 100% <br/> (0xfee300ff)
  internal static let mdThemeDarkOnTertiaryContainer = ColorName(rgbaValue: 0xFEE3_00FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#8f909a"></span>
  /// Alpha: 100% <br/> (0x8f909aff)
  internal static let mdThemeDarkOutline = ColorName(rgbaValue: 0x8F90_9AFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#b3c5ff"></span>
  /// Alpha: 100% <br/> (0xb3c5ffff)
  internal static let mdThemeDarkPrimary = ColorName(rgbaValue: 0xB3C5_FFFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#013fa3"></span>
  /// Alpha: 100% <br/> (0x013fa3ff)
  internal static let mdThemeDarkPrimaryContainer = ColorName(rgbaValue: 0x013F_A3FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#78d1ff"></span>
  /// Alpha: 100% <br/> (0x78d1ffff)
  internal static let mdThemeDarkSecondary = ColorName(rgbaValue: 0x78D1_FFFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#004c68"></span>
  /// Alpha: 100% <br/> (0x004c68ff)
  internal static let mdThemeDarkSecondaryContainer = ColorName(rgbaValue: 0x004C_68FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#000000"></span>
  /// Alpha: 100% <br/> (0x000000ff)
  internal static let mdThemeDarkShadow = ColorName(rgbaValue: 0x0000_00FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#001f24"></span>
  /// Alpha: 100% <br/> (0x001f24ff)
  internal static let mdThemeDarkSurface = ColorName(rgbaValue: 0x001F_24FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#b3c5ff"></span>
  /// Alpha: 100% <br/> (0xb3c5ffff)
  internal static let mdThemeDarkSurfaceTint = ColorName(rgbaValue: 0xB3C5_FFFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#b3c5ff"></span>
  /// Alpha: 100% <br/> (0xb3c5ffff)
  internal static let mdThemeDarkSurfaceTintColor = ColorName(rgbaValue: 0xB3C5_FFFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#45464f"></span>
  /// Alpha: 100% <br/> (0x45464fff)
  internal static let mdThemeDarkSurfaceVariant = ColorName(rgbaValue: 0x4546_4FFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#dfc700"></span>
  /// Alpha: 100% <br/> (0xdfc700ff)
  internal static let mdThemeDarkTertiary = ColorName(rgbaValue: 0xDFC7_00FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#504700"></span>
  /// Alpha: 100% <br/> (0x504700ff)
  internal static let mdThemeDarkTertiaryContainer = ColorName(rgbaValue: 0x5047_00FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f6feff"></span>
  /// Alpha: 100% <br/> (0xf6feffff)
  internal static let mdThemeLightBackground = ColorName(rgbaValue: 0xF6FE_FFFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ba1a1a"></span>
  /// Alpha: 100% <br/> (0xba1a1aff)
  internal static let mdThemeLightError = ColorName(rgbaValue: 0xBA1A_1AFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffdad6"></span>
  /// Alpha: 100% <br/> (0xffdad6ff)
  internal static let mdThemeLightErrorContainer = ColorName(rgbaValue: 0xFFDA_D6FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#d0f8ff"></span>
  /// Alpha: 100% <br/> (0xd0f8ffff)
  internal static let mdThemeLightInverseOnSurface = ColorName(rgbaValue: 0xD0F8_FFFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#b3c5ff"></span>
  /// Alpha: 100% <br/> (0xb3c5ffff)
  internal static let mdThemeLightInversePrimary = ColorName(rgbaValue: 0xB3C5_FFFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#00363d"></span>
  /// Alpha: 100% <br/> (0x00363dff)
  internal static let mdThemeLightInverseSurface = ColorName(rgbaValue: 0x0036_3DFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#001f24"></span>
  /// Alpha: 100% <br/> (0x001f24ff)
  internal static let mdThemeLightOnBackground = ColorName(rgbaValue: 0x001F_24FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  internal static let mdThemeLightOnError = ColorName(rgbaValue: 0xFFFF_FFFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#410002"></span>
  /// Alpha: 100% <br/> (0x410002ff)
  internal static let mdThemeLightOnErrorContainer = ColorName(rgbaValue: 0x4100_02FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  internal static let mdThemeLightOnPrimary = ColorName(rgbaValue: 0xFFFF_FFFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#001849"></span>
  /// Alpha: 100% <br/> (0x001849ff)
  internal static let mdThemeLightOnPrimaryContainer = ColorName(rgbaValue: 0x0018_49FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  internal static let mdThemeLightOnSecondary = ColorName(rgbaValue: 0xFFFF_FFFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#001e2c"></span>
  /// Alpha: 100% <br/> (0x001e2cff)
  internal static let mdThemeLightOnSecondaryContainer = ColorName(rgbaValue: 0x001E_2CFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#001f24"></span>
  /// Alpha: 100% <br/> (0x001f24ff)
  internal static let mdThemeLightOnSurface = ColorName(rgbaValue: 0x001F_24FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#45464f"></span>
  /// Alpha: 100% <br/> (0x45464fff)
  internal static let mdThemeLightOnSurfaceVariant = ColorName(rgbaValue: 0x4546_4FFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  internal static let mdThemeLightOnTertiary = ColorName(rgbaValue: 0xFFFF_FFFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#201c00"></span>
  /// Alpha: 100% <br/> (0x201c00ff)
  internal static let mdThemeLightOnTertiaryContainer = ColorName(rgbaValue: 0x201C_00FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#757680"></span>
  /// Alpha: 100% <br/> (0x757680ff)
  internal static let mdThemeLightOutline = ColorName(rgbaValue: 0x7576_80FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#2c59bc"></span>
  /// Alpha: 100% <br/> (0x2c59bcff)
  internal static let mdThemeLightPrimary = ColorName(rgbaValue: 0x2C59_BCFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#dae1ff"></span>
  /// Alpha: 100% <br/> (0xdae1ffff)
  internal static let mdThemeLightPrimaryContainer = ColorName(rgbaValue: 0xDAE1_FFFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#006689"></span>
  /// Alpha: 100% <br/> (0x006689ff)
  internal static let mdThemeLightSecondary = ColorName(rgbaValue: 0x0066_89FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#c3e8ff"></span>
  /// Alpha: 100% <br/> (0xc3e8ffff)
  internal static let mdThemeLightSecondaryContainer = ColorName(rgbaValue: 0xC3E8_FFFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#000000"></span>
  /// Alpha: 100% <br/> (0x000000ff)
  internal static let mdThemeLightShadow = ColorName(rgbaValue: 0x0000_00FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f6feff"></span>
  /// Alpha: 100% <br/> (0xf6feffff)
  internal static let mdThemeLightSurface = ColorName(rgbaValue: 0xF6FE_FFFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#2c59bc"></span>
  /// Alpha: 100% <br/> (0x2c59bcff)
  internal static let mdThemeLightSurfaceTint = ColorName(rgbaValue: 0x2C59_BCFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#2c59bc"></span>
  /// Alpha: 100% <br/> (0x2c59bcff)
  internal static let mdThemeLightSurfaceTintColor = ColorName(rgbaValue: 0x2C59_BCFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#e1e2ec"></span>
  /// Alpha: 100% <br/> (0xe1e2ecff)
  internal static let mdThemeLightSurfaceVariant = ColorName(rgbaValue: 0xE1E2_ECFF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#6b5f00"></span>
  /// Alpha: 100% <br/> (0x6b5f00ff)
  internal static let mdThemeLightTertiary = ColorName(rgbaValue: 0x6B5F_00FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#fee300"></span>
  /// Alpha: 100% <br/> (0xfee300ff)
  internal static let mdThemeLightTertiaryContainer = ColorName(rgbaValue: 0xFEE3_00FF)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#003fa3"></span>
  /// Alpha: 100% <br/> (0x003fa3ff)
  internal static let seed = ColorName(rgbaValue: 0x003F_A3FF)
}

// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let components = RGBAComponents(rgbaValue: rgbaValue).normalized
    self.init(red: components[0], green: components[1], blue: components[2], alpha: components[3])
  }
}

private struct RGBAComponents {
  let rgbaValue: UInt32

  private var shifts: [UInt32] {
    [
      rgbaValue >> 24, // red
      rgbaValue >> 16, // green
      rgbaValue >> 8, // blue
      rgbaValue, // alpha
    ]
  }

  private var components: [CGFloat] {
    shifts.map { CGFloat($0 & 0xFF) }
  }

  var normalized: [CGFloat] {
    components.map { $0 / 255.0 }
  }
}

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
