import Foundation
import RxSwift
import RxCocoa
import SideMenu
import UIKit

class DrawerMenuCoordinator: BaseCoordinator {
    private let viewModel: DrawerMenuViewModelType

    init(navigationController: UINavigationController, viewModel: DrawerMenuViewModelType) {
        self.viewModel = viewModel
        super.init(navigationController: navigationController)
    }

    override func start() {
        setUpSideMenu()
        viewModel.output
            .menuSelected
            .withUnretained(self)
            .subscribe { this, screen in
                this.selectScreen(screen)
            }
            .disposed(by: disposeBag)
    }

    func selectScreen(_ screen: DrawerMenuScreen) {
        logger.info("DrawerMenuCoordinator selectScreen: \(screen)")
        switch screen {
        case .dashboard:
            let viewModel = DashboardViewModel()
            let coordinator = DashboardCoordinator(navigationController: self.navigationController,
                                                   viewModel: viewModel)
            start(coordinator: coordinator)
        case .movies:
            let viewModel = MovieListViewModel()
            let coordinator = MovieListCoordinator(navigationController: self.navigationController,
                                                   viewModel: viewModel)
            start(coordinator: coordinator)
        case .settings:
            break
        case .signOut:
            break
        }
        self.navigationController.dismiss(animated: true)
    }
    
    private func setUpSideMenu() {
        // Define the menus
        let drawer = DrawerMenuViewController(viewModel: self.viewModel)
        let leftMenuNavigationController = SideMenuNavigationController(rootViewController: drawer)
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
        leftMenuNavigationController.navigationBar.isHidden = true

        let style = SideMenuPresentationStyle.menuSlideIn
        style.backgroundColor = .black
        style.presentingEndAlpha = 0.32
        style.onTopShadowColor = .black
        style.onTopShadowRadius = 4.0
        style.onTopShadowOpacity = 0.2
        style.onTopShadowOffset = CGSize(width: 2.0, height: 0.0)

        var settings = SideMenuSettings()
        settings.presentationStyle = style
        settings.menuWidth = max(round(min((UIScreen.main.bounds.width), (UIScreen.main.bounds.height)) * 0.75), 240)
        settings.statusBarEndAlpha = 0.0

        leftMenuNavigationController.settings = settings
    }
}
