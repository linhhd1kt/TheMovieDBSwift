import Foundation
import RxSwift
import RxCocoa
import SideMenu
import UIKit

protocol DashboardNavigatable {
    func navigateToDashboard()
}

class DrawerMenuCoordinator: BaseCoordinator {
    private let viewModel: NavigationViewModelType
    
    private let menuNavigationItem: UIBarButtonItem
    private let logoNavigationItem: UIButton
    private let profileNavigationItem: UIBarButtonItem
    private let searchNavigationItem: UIBarButtonItem
    
    init(navigationController: UINavigationController,
         viewModel: NavigationViewModelType,
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

        self.viewModel = viewModel
        super.init(navigationController: navigationController)
    }

    override func start() {
        setUpNavigationItem()
        setUpSideMenu()
        bindOutput(viewModel.output)
    }

    func selectScreen(_ screen: DrawerMenuScreen) {
        logger.info("DrawerMenuCoordinator selectScreen: \(screen)")
        switch screen {
        case .menu:
            self.navigationController
                .present(SideMenuManager.default.leftMenuNavigationController!,
                         animated: true,
                         completion: nil)
            break
        case .dashboard:
            let viewModel = DashboardViewModel()
            let coordinator = DashboardCoordinator(navigationController: self.navigationController,
                                                   viewModel: viewModel,
                                                   navigationViewModel: self.viewModel)
            start(coordinator: coordinator)
            self.navigationController.dismiss(animated: true)
        case .profile: // TODO navigate to profile
            self.navigationController.dismiss(animated: true)
            break
        case .search: // TODO navigate to search
            self.navigationController.dismiss(animated: true)
            break
        case .movies:
            let viewModel = MovieListViewModel()
            let coordinator = MovieListCoordinator(navigationController: self.navigationController,
                                                   viewModel: viewModel,
                                                   navigationViewModel: self.viewModel)
            start(coordinator: coordinator)
            self.navigationController.dismiss(animated: true)
        case .settings:
            self.navigationController.dismiss(animated: true)
            break
        case .signOut:
            self.navigationController.dismiss(animated: true)
            break
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
    
    
    private func setUpNavigationItem() {
        menuNavigationItem.rx.tap.asObservable()
            .map { DrawerMenuScreen.menu }
            .subscribe(onNext: { item in
                print(item)
            }).disposed(by: disposeBag)
                
//        ControlEvent.merge(menuNavigationItem.rx.tap.map { DrawerMenuScreen.menu },
//                         logoNavigationItem.rx.tap.map { DrawerMenuScreen.dashboard },
//                         profileNavigationItem.rx.tap.map { DrawerMenuScreen.profile },
//                         searchNavigationItem.rx.tap.map { DrawerMenuScreen.search })
//        .asObservable()
//        .debug("xxx Navigation item Select")
////        .bind(to: viewModel.input.menuSelect)
//        .subscribe()
//        .disposed(by: disposeBag)
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

extension DrawerMenuCoordinator: DashboardNavigatable {
    func navigateToDashboard() {
        self.selectScreen(.dashboard)
    }
}