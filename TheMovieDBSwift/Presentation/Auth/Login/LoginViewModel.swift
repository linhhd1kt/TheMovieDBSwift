import RxSwift
import RxCocoa
import NSObject_Rx
import Action

final class LoginViewModel: BaseViewModel {
    // MARK: - Dependency
    private let usecase: AuthUseCaseType
    private var coordinator: CoordinatorType {
        guard let coordinator = ServiceFacade.getService(CoordinatorType.self) else {
            preconditionFailure("Coordinator should be registered!")
        }
        return coordinator
    }

    // MARK: - Input
    private let usernameTextObserver = BehaviorSubject<String>(value: "")
    private let passwordTextObserver = BehaviorSubject<String>(value: "")
    private let loginActionObserver = PublishSubject<Void>()
    private let registerActionObserver = PublishSubject<Void>()
    private let forgotPasswordActionObserver = PublishSubject<Void>()

    // MARK: - Output
    private let errorObserver = BehaviorSubject<String>(value: "")
    private let loginButtonEnabledObserver = BehaviorSubject<Bool>(value: false)
    
    init(usecase: AuthUseCaseType = AuthUseCase()) {
        self.usecase = usecase
        super.init()
        self.binding()
    }
    
    private func binding() {
        // login button enabled when username and password is not empty
        let loginInfo = Observable.combineLatest(usernameTextObserver, passwordTextObserver)
        
        loginInfo
            .debug("Login Info")
            .map { !$0.isEmpty && !$1.isEmpty }
            .debug("Login Info Valid")
            .bind(to: loginButtonEnabledObserver)
            .disposed(by: disposeBag)

        loginActionObserver
            .withLatestFrom(loginInfo.map { ($0, $1) })
            .bind(to: usecase.input.login)
            .disposed(by: disposeBag)
        
        usecase.output.loginResult
            .elements
            .filter { $0.success == true }
            .withUnretained(self)
            .subscribe { this, _ in
                this.coordinator.start()
            }
            .disposed(by: disposeBag)
    }
}

extension LoginViewModel: LoginViewModelType {
    var input: LoginViewModelInputType {
        return self
    }
    var output: LoginViewModelOutputType {
        return self
    }
}

extension LoginViewModel: LoginViewModelInputType {
    var username: AnyObserver<String> {
        return usernameTextObserver.asObserver()
    }
    var password: AnyObserver<String> {
        return passwordTextObserver.asObserver()
    }
    var loginAction: AnyObserver<Void> {
        return loginActionObserver.asObserver()
    }
    var registerAction: AnyObserver<Void> {
        return registerActionObserver.asObserver()
    }
    var forgotPasswordAction: AnyObserver<Void> {
        return forgotPasswordActionObserver.asObserver()
    }
}

extension LoginViewModel: LoginViewModelOutputType {
    var loginButtonEnabled: Observable<Bool> {
        return loginButtonEnabledObserver
    }
    var loginResult: ActionResult<Credential> {
        let enabled = Observable.combineLatestAll(usecase.output.loginResult.enabled.debug("Login Result Enabled"),
                                                  loginButtonEnabledObserver.debug("Login Button Enabled"))
            .debug("Login Result Enabled combine with login button")
        return usecase.output.loginResult
            .swapEnabled(enabled)
    }
}
