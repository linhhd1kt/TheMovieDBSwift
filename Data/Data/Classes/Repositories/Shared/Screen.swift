//
//  DrawerMenuScreen.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Foundation

public enum Screen: Int, CaseIterable {
  case signIn = -6
  case signUp = -5
  case menu = -4
  case dashboard = -3
  case profile = -2
  case search = -1
  case movies = 0
  case settings = 1
  case signOut = 2
  case toggleTheme = 3
  case toggleLanguage = 4

  public var name: String {
    switch self {
    case .menu: return "Menu"
    case .dashboard: return "Dashboard"
    case .profile: return "Profile"
    case .search: return "Search"
    case .movies: return "Movies"
    case .settings: return "Setting"
    case .signOut: return "Logout"
    case .signIn: return "Sign In"
    case .signUp: return "Sign Up"
    case .toggleTheme: return "Toggle Theme"
    case .toggleLanguage: return "Toggle Language"
    }
  }

  public static var displayItems: [Screen] {
    return [.movies, .settings, .signOut, .toggleTheme, .toggleLanguage]
  }
}
