//
//  DrawerMenuScreen.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 18/10/2022.
//

import Foundation

enum DrawerMenuScreen: Int, CaseIterable {
    case menu = -4
    case dashboard = -3
    case profile = -2
    case search = -1    
    case movies = 0
    case settings = 1
    case signOut = 2
    
    var name: String {
        switch self {
        case .menu: return "Menu"
        case .dashboard: return "Dashboard"
        case .profile: return "Profile"
        case .search: return "Search"
        case .movies: return "Movies"
        case .settings: return "Setting"
        case .signOut: return "Logout"
        }
    }
    
    static var displayItems: [DrawerMenuScreen] {
        return [.movies, .settings, .signOut]
    }
}
