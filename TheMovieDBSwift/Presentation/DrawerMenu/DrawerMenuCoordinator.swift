import Foundation
import RxSwift
import RxCocoa
import SideMenu
import UIKit

class DrawerMenuCoordinator: BaseCoordinator {
    private let drawerMenuViewModel: DrawerMenuViewModelType

    init(navigationController: UINavigationController, drawerMenuViewModel: DrawerMenuViewModelType) {
        self.drawerMenuViewModel = drawerMenuViewModel
        super.init(navigationController: navigationController)
    }

    override func start() {
        drawerMenuViewModel.output
            .menuSelected
            .distinctUntilChanged()
            .withUnretained(self)
            .subscribe(onNext: { this, screen in
                this.selectScreen(screen)
            })
            .disposed(by: disposeBag)
    }

    func selectScreen(_ screen: DrawerMenuScreen) {
        print("XXX did select screen: \(screen)")
        switch screen {
        case .dashboard:
            let dashboardViewModel = DashboardViewModel()
            let coordinator = DashboardCoordinator(navigationController: self.navigationController,
                                                   viewModel: dashboardViewModel)
            start(coordinator: coordinator)
        case .settings:
            break
        case .signOut:
            break
        }
    }
}
