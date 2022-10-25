//
//  DrawerMenuScreen.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 18/10/2022.
//

import Foundation

enum DrawerMenuScreen: Int, CaseIterable {    
    case dashboard = 0
    case movies
    case settings
    case signOut
    
    var name: String {
        switch self {
        case .dashboard: return "Dashboard"
        case .movies: return "Movies"
        case .settings: return "Setting"
        case .signOut: return "Logout"
        }
    }
}
