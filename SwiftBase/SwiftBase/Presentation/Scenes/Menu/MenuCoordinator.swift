//
//  MenuCoordinator.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Data
import Design
import Domain
import RxCocoa
import RxSwift
import Services
import SideMenu
import UIKit


protocol DashboardNavigatable {
  func navigateToDashboard()
}

class MenuCoordinator: BaseCoordinator {
//  private let menuNavigationItem: UIBarButtonItem
//  private let logoNavigationItem: UIButton
//  private let profileNavigationItem: UIBarButtonItem
//  private let searchNavigationItem: UIBarButtonItem

  private let navigationViewModel: NavigationViewModelType

  private var logger: Logger {
    guard let logger = ServiceFacade.getService(LoggerType.self) as? Logger else {
      fatalError("Logger should be initilized!")
    }
    return logger
  }

  private var design: DesignType {
    guard let design = ServiceFacade.getService(DesignType.self) else {
      fatalError("Design should be initilized!")
    }
    return design
  }

  private var network: Networking {
    guard let network = ServiceFacade.getService(Networking.self) else {
      fatalError("Networking should be initilized!")
    }
    return network
  }
  
  private var config: AppConfigType {
    guard let config = ServiceFacade.getService(AppConfigType.self) else {
      fatalError("App Config should be initilized!")
    }
    return config
  }

  init(navigationController: UINavigationController, navigationViewModel: NavigationViewModelType){
    // initial navigation items
//    menuNavigationItem = navigationItemFactory.makeNavigationItem(.menu)
//    logoNavigationItem = navigationItemFactory.makeLogoButton()
//    profileNavigationItem = navigationItemFactory.makeNavigationItem(.profile)
//    searchNavigationItem = navigationItemFactory.makeNavigationItem(.search)
//    let navigationItem = UINavigationItem()
//    navigationItem.leftBarButtonItem = menuNavigationItem
//    navigationItem.titleView = logoNavigationItem
//    navigationItem.rightBarButtonItems = [searchNavigationItem, profileNavigationItem]
    

    self.navigationViewModel = navigationViewModel
    super.init(navigationController: navigationController)
  }

  override func start() {
    bindOutput(navigationViewModel.output)
  }

  func selectScreen(_ screen: Screen) {
    
    logger.info("Menu coordinator select screen: \(screen)")
    switch screen {
    case .signIn:
      removeChildCoordinators()
      showLogin()
    case .profile:
      if let menu = SideMenuManager.default.leftMenuNavigationController {
        navigationController
          .present(menu, animated: true, completion: nil)
      }
    case .signOut:
      removeChildCoordinators()
      navigationController.dismiss(animated: true)
      showLogin()
    case .signUp:
      print("tap sign up in profile menu")
    case .toggleTheme:
      removeChildCoordinators()
      design.toggleTheme()
      navigationController.dismiss(animated: true)
      (parentCoordinator as? ThemeUpdateListener)?.didToggleTheme()
    case .dashboard:
      removeChildCoordinators()
      let movieRepository = MovieRepository(network: network)
      let movieTranslator = MovieTranslator()
      let movieUsecase = MovieUseCase(repository: movieRepository,
                                      translator: movieTranslator)
      
      let tvRepository = TvRepository(network: network)
      let tvTranslator = TvTranslator()
      let tvUseCase = TvUseCase(repository: tvRepository, translator: tvTranslator)
      
      let viewModel = DashboardViewModel(movieUseCase: movieUsecase, tvUseCase: tvUseCase)
      let coordinator = DashboardCoordinator(navigationController: navigationController,
                                             viewModel: viewModel,
                                             navigationViewModel: navigationViewModel)
      start(coordinator: coordinator)
    case .toggleLanguage:
      // current ios not support
      navigationController.dismiss(animated: true)
      config.toggleLanguage()
    default:
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

  private func showLogin() {
    let translator = AuthTranslator()
    let repository = AuthRepository(network: network)
    let usecase = AuthUseCase(repository: repository, translator: translator)
    let viewModel = LoginViewModel(usecase: usecase)
    let coordinator = LoginCoordinator(navigationController: navigationController,
                                       viewModel: viewModel,
                                       navigationViewModel: navigationViewModel)
    start(coordinator: coordinator)
  }

  deinit {}
}

extension MenuCoordinator: DashboardNavigatable {
  func navigateToDashboard() {
    selectScreen(.dashboard)
  }
}

protocol LoginListener {
  func didLogedIn()
  func didLogOut()
}

extension MenuCoordinator: LoginListener {
  func didLogedIn() {
    navigationViewModel.input.navigationSelect.onNext(.dashboard)
  }

  func didLogOut() {}
}
