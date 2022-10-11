import RxSwift
import RxCocoa
import NSObject_Rx
import Action

final class LoginViewModel {
    // MARK: - Dependency
    private let usecase: AuthUseCase
    private var coordinator: Coordinator {
        guard let coordinator = ServiceFacade.getService(Coordinator.self) else {
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
    private let credentialObserver = BehaviorSubject<CredentialModel>(value: .default)
    private let errorObserver = BehaviorSubject<String>(value: "")
    private let loginButtonEnabledObserver = BehaviorSubject<Bool>(value: false)
    
    init(usecase: AuthUseCase) {
        self.usecase = usecase
        self.binding()
    }
    
    private func binding() {
        // login button enabled when username and password is not empty
        let loginInfo = Observable.combineLatest(usernameTextObserver, passwordTextObserver)
            .share(replay: 1)
        
        loginInfo
            .map { !$0.isEmpty && !$1.isEmpty }
            .bind(to: loginButtonEnabledObserver)
            .disposed(by: disposeBag)

        loginActionObserver
            .withLatestFrom(loginInfo.map { ($0, $1) })
            .bind(to: usecase.input.login)
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
    var error: Observable<String> {
        return errorObserver
    }
    var loginButtonEnabled: Observable<Bool> {
        return loginButtonEnabledObserver
    }
    var credential: ActionResult<CredentialModel> {
        return usecase.output.loginResult
    }
}

extension LoginViewModel: HasDisposeBag {}
