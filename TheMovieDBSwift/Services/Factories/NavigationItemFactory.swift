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
        case .menu: return R.image.icMenu()
        case .profile: return R.image.icProfile()
        case .search: return R.image.icSearch()
        }
    }
    
    func makeNavigationItem(_ style: NavigationItemStyle) -> UIBarButtonItem {
        let icon = makeNavigatonIcon(style)
        return UIBarButtonItem(image: icon, style: .plain, target: nil, action: nil)
    }

    func makeLogoButton() -> UIButton {
        let button = UIButton()
        button.setImage(R.image.icLogo(), for: .normal)
        return button
    }
}
