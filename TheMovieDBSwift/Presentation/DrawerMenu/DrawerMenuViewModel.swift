import RxSwift

final class DrawerMenuViewModel: BaseViewModel {
    // MARK: - Dependency
    
    // MARK: - Input
    private let menuSelectObserver = BehaviorSubject<DrawerMenuScreen>(value: .dashboard)
    
    // MARK: - Output
    private let menuSelectedObserver = BehaviorSubject<DrawerMenuScreen>(value: .dashboard)
    private let menuItemsObserver = BehaviorSubject<[DrawerMenuScreen]>(value: DrawerMenuScreen.allCases)
    
    override init() {
        super.init()
        self.binding()
    }
    
    private func binding() {
        Observable.just(DrawerMenuScreen.allCases)
            .bind(to: menuItemsObserver)
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
        return menuSelectObserver.asObserver()
    }
}

extension DrawerMenuViewModel: DrawerMenuViewModelOutputType {
    var menuSelected: Observable<DrawerMenuScreen>{
        return menuSelectedObserver.asObserver()
    }
    var menuItems: Observable<[DrawerMenuScreen]> {
        return menuItemsObserver.asObservable()
    }
}
