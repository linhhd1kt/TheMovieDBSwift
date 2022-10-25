import RxSwift

final class DrawerMenuViewModel: BaseViewModel {
    // MARK: - Dependency
    
    // MARK: - Input
    private let selectMenuObserver = BehaviorSubject<DrawerMenuScreen>(value: .dashboard)

    // MARK: - Output
    private let menuSelectedObserver = BehaviorSubject<DrawerMenuScreen>(value: .dashboard)
    private let menuItemsObserver = BehaviorSubject<[DrawerMenuScreen]>(value: DrawerMenuScreen.allCases)
    
    override init() {
        super.init()
        self.binding()
    }

    private func binding() {
        selectMenuObserver
            .bind(to: menuSelectedObserver)
            .disposed(by: disposeBag)
    }
}

extension DrawerMenuViewModel: DrawerMenuViewModelType {
    var input: DrawerMenuViewModelInputType {
        return self
    }
    var output: DrawerMenuViewModelOutputType {
        return self
    }
}

extension DrawerMenuViewModel: DrawerMenuViewModelInputType {
    var menuSelect: AnyObserver<DrawerMenuScreen> {
        return selectMenuObserver.asObserver()
    }
}

extension DrawerMenuViewModel: DrawerMenuViewModelOutputType {
    var menuSelected: Observable<DrawerMenuScreen>{
        return menuSelectedObserver.asObservable()
    }
    var menuItems: Observable<[DrawerMenuScreen]> {
        return menuItemsObserver.asObservable()
    }
}
