import Foundation
import RxSwift
import RxCocoa
//import RxSwiftExt

struct LoginInfo {
    let username: String
    let password: String
}

final class LoginViewModel: ViewModel {
    struct Input {
        let username = PublishSubject<String?>()
        let password = PublishSubject<String?>()
        let loginAction = PublishSubject<Void>()
        let forgotPasswordAction = PublishSubject<Void>()
        let registerAction = PublishSubject<Void>()
    }
    struct Output {}
    
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

extension LoginViewModel: ViewModelType {
    @discardableResult
    func transform(input: Input) -> Output {
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
        
        return Output()
        
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
