//
//  NavigationItemFactory.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 25/10/2022.
//

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
    private func makeNavigatonIcon(_ style: NavigationItemStyle) -> UIImage? {
        switch style {
        case .menu: return design.style.icons.menu.symbol
        case .profile: return design.style.icons.profile.symbol
        case .search: return design.style.icons.search.symbol
        }
    }

    func makeNavigationItem(_ style: NavigationItemStyle) -> UIBarButtonItem {
        let icon = makeNavigatonIcon(style)
        let barButton = UIBarButtonItem(image: icon, style: .plain, target: nil, action: nil)
        var tinColor: UIColor?
        switch style {
        case .search:
            tinColor = design.style.colors.tertiary
        default:
            tinColor = design.style.colors.background
        }
        barButton.tintColor = tinColor
        return barButton
    }

    func makeLogoButton() -> UIButton {
        let button = UIButton()
        button.imageEdgeInsets = UIEdgeInsets(top: -8, left: 0, bottom: 8, right: 0)
        button.setImage(design.style.icons.logo.symbol, for: .normal)
        return button
    }
}

extension NavigationItemFactory: HasDeSign {}
