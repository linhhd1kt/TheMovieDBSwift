import RxSwift
import UIKit
import RxCocoa
import NSObject_Rx

class BaseViewController: UIViewController {
    var loading: ActivityIndicator = ActivityIndicator()
    var error: ErrorTracker = ErrorTracker()
    
    var logger: Logable {
        guard let logger = ServiceFacade.getService(Logable.self) else {
            fatalError("Logger should be implemented!")
        }
        return logger
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        logger.debug("\(className) is Initialized.")
        tracking()
    }

    private func tracking() {
//        loading
//            .drive()
//            .disposed(by: disposeBag)
//        error
//            .drive(rx.error)
//            .disposed(by: disposeBag)
    }
    deinit {
        logger.debug("\(className) is Release.")
    }
}


final class LoginViewController: BaseViewController {
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    
    private let viewModel: LoginViewModelType
        
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: LoginViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindInput(viewModel.input)
        bindOutput(viewModel.output)
    }
    
    private func bindInput(_ input: LoginViewModelInputType) {
        usernameTextField.rx.text
            .filterNil()
            .bind(to: input.username)
            .disposed(by: disposeBag)
        passwordTextField.rx.text
            .filterNil()
            .bind(to: input.password)
            .disposed(by: disposeBag)
        loginButton.rx.tap
            .bind(to: input.loginAction)
            .disposed(by: disposeBag)
    }

    private func bindOutput(_ output: LoginViewModelOutputType) {
        output.error
            .bind(to: rx.showMessage)
            .disposed(by: disposeBag)
        output.credential.elements
            .asDriverOnErrorJustComplete()
            .drive()
            .disposed(by: disposeBag)
    }
}
