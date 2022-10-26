//
//  NavigationItemFactory.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 25/10/2022.
//

import UIKit
import UIKit

enum NavigationItemStyle {
    case menu
    case profile
    case search
}

protocol NavigationItemCreatable {
    func makeNavigationItem(_ style: NavigationItemStyle) -> UIBarButtonItem
    func makeLogoButton() -> UIButton
}

class NavigationItemFactory: NavigationItemCreatable {
    private func makeNavigatonIcon(_ style: NavigationItemStyle) -> UIImage {
        switch style {
        case .menu: return #imageLiteral(resourceName: "ic_menu")
        case .profile: return #imageLiteral(resourceName: "ic_profile")
        case .search: return #imageLiteral(resourceName: "ic_search")
        }
    }
    
    func makeNavigationItem(_ style: NavigationItemStyle) -> UIBarButtonItem {
        let icon = makeNavigatonIcon(style)
        return UIBarButtonItem(image: icon, style: .plain, target: nil, action: nil)
    }

    func makeLogoButton() -> UIButton {
        var configuration = UIButton.Configuration.plain()
        configuration.image = #imageLiteral(resourceName: "ic_logo")
        configuration.contentInsets = .init(top: -8, leading: 0, bottom: 8, trailing: 0)
        return UIButton(configuration: configuration)
    }
}
