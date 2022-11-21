import Foundation
import RxSwift
import RxCocoa
import SideMenu
import UIKit

protocol DashboardNavigatable {
    func navigateToDashboard()
}

class DrawerMenuCoordinator: BaseCoordinator {
    private let menuNavigationItem: UIBarButtonItem
    private let logoNavigationItem: UIButton
    private let profileNavigationItem: UIBarButtonItem
    private let searchNavigationItem: UIBarButtonItem
    
    private let navigationViewModel: NavigationViewModelType
    
    init(navigationController: UINavigationController,
         navigationViewModel: NavigationViewModelType,
         navigationItemFactory: NavigationItemCreatable = NavigationItemFactory()) {
       
        // initial navigation items
        menuNavigationItem = navigationItemFactory.makeNavigationItem(.menu)
        logoNavigationItem = navigationItemFactory.makeLogoButton()
        profileNavigationItem = navigationItemFactory.makeNavigationItem(.profile)
        searchNavigationItem = navigationItemFactory.makeNavigationItem(.search)
        let navigationItem = UINavigationItem()
        navigationItem.leftBarButtonItem = menuNavigationItem
        navigationItem.titleView = logoNavigationItem
        navigationItem.rightBarButtonItems = [searchNavigationItem, profileNavigationItem]

        self.navigationViewModel = navigationViewModel
        super.init(navigationController: navigationController)
    }

    override func start() {
        setUpSideMenu()
        bindOutput(navigationViewModel.output)
    }

    func selectScreen(_ screen: Screen) {
        removeChildCoordinators()
        logger.info("DrawerMenuCoordinator selectScreen: \(screen)")
        switch screen {
        case .menu:
            if let menu = SideMenuManager.default.leftMenuNavigationController {
                self.navigationController
                .present(menu, animated: true, completion: nil)
            }
        case .dashboard:
            let viewModel = DashboardViewModel()
            let coordinator = DashboardCoordinator(navigationController: self.navigationController,
                                                   viewModel: viewModel,
                                                   navigationViewModel: self.navigationViewModel)
            start(coordinator: coordinator)
            self.navigationController.dismiss(animated: true)
        case .profile:
            self.navigationController.dismiss(animated: true)
        case .search:
            self.navigationController.dismiss(animated: true)
        case .movies:
            let viewModel = MovieListViewModel()
            let coordinator = MovieListCoordinator(navigationController: self.navigationController,
                                                   viewModel: viewModel,
                                                   navigationViewModel: self.navigationViewModel)
            start(coordinator: coordinator)
            self.navigationController.dismiss(animated: true)
        case .settings:
            self.navigationController.dismiss(animated: true)
        case .signOut:
            self.navigationController.dismiss(animated: true)
        case .signUp:
            print("tap sign up in profile menu")
        case .signIn:
            let viewModel = LoginViewModel()
            let coordinator = LoginCoordinator(navigationController: self.navigationController,
                                               viewModel: viewModel,
                                               navigationViewModel: navigationViewModel)
            start(coordinator: coordinator)
        case .toggleTheme:
            design.toggleTheme()
            self.navigationController.dismiss(animated: true)
        }
    }
    
    private func bindOutput(_ output: NavigationViewModelOutputType) {
        output.navigationSelected
            .withUnretained(self)
            .subscribe { this, screen in
                this.selectScreen(screen)
            }
            .disposed(by: disposeBag)
    }
    
    private func setUpSideMenu() {
        // Define the menus
        let drawer = DrawerMenuViewController(viewModel: self.navigationViewModel)
        let leftMenuNavigationController = SideMenuNavigationController(rootViewController: drawer)
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
        leftMenuNavigationController.navigationBar.isHidden = true
        leftMenuNavigationController.blurEffectStyle = .prominent

        let style = SideMenuPresentationStyle.menuSlideIn
        style.backgroundColor = design.style.colors.background
//        style.presentingEndAlpha = 0.32
        style.onTopShadowColor = design.style.colors.primary
        style.onTopShadowRadius = 4.0
        style.onTopShadowOpacity = 0.2
        style.onTopShadowOffset = CGSize(width: 2.0, height: 0.0)
//
        var settings = SideMenuSettings()
        settings.presentationStyle = style
        settings.menuWidth = max(round(min((UIScreen.main.bounds.width), (UIScreen.main.bounds.height)) * 0.75), 240)
        settings.statusBarEndAlpha = 0.0

        leftMenuNavigationController.settings = settings
    }
}

extension DrawerMenuCoordinator: DashboardNavigatable {
    func navigateToDashboard() {
        self.selectScreen(.dashboard)
    }
}
