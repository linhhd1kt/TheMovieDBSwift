import RxSwift
import RxCocoa

final class LoginViewModel: BaseViewModel {
    
    private var authUseCase: AuthUseCase
    private var coordinator: Coordinator {
        guard let coordinator = ServiceFacade.getService(Coordinator.self) else {
            preconditionFailure("Coordinator should be registered!")
        }
        return coordinator
    }

    required init() {
        fatalError("init() has not been implemented")
    }

    init(authUseCase: AuthUseCase) {
        self.authUseCase = authUseCase
        super.init()
    }
}

extension LoginViewModel: LoginViewModeltype {

    typealias InputType = LoginViewModelInputType
    typealias OutputType = LoginViewModelOutputType

    struct Input: LoginViewModelInputType {
        var username = PublishSubject<String?>()
        var password = PublishSubject<String?>()
        var loginAction = PublishSubject<Void>()
        var forgotPasswordAction = PublishSubject<Void>()
        var registerAction = PublishSubject<Void>()
    }
    struct Output: LoginViewModelOutputType {
        var result: Driver<Credential?>
    }
    
    @discardableResult
    func transform(input: LoginViewModelInputType) -> LoginViewModelOutputType {
        let loginAction = input.loginAction
            .withLatestFrom(Observable
                .combineLatest(input.username.compactMap { $0 },
                               input.password.compactMap { $0 }))
            .map { LoginInfo(username: $0, password: $1) }

        loginAction
            .flatMapLatest { [unowned self] info in
                self.doLogin(username: info.username, password: info.password)
            }
            .subscribe()
            .disposed(by: disposeBag)
        
        return Output(result: Driver.just(nil))
        
    }
    
    func doLogin(username: String, password: String) -> Observable<Credential?> {
        self.authUseCase.login(username: username, password: password)
            .trackError(error)
            .trackActivity(loading)
            .catchErrorJustComplete()
    }
}

protocol UseCaseProvider {
    func makePostsUseCase() -> AuthUseCase
}
