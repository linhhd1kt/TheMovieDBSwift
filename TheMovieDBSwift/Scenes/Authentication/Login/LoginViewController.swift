import RxSwift
import UIKit
import RxCocoa


class BaseViewController: UIViewController {
    
}


final class LoginViewController: BaseViewController {
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    
    private let viewModel: LoginViewModeltype & Trackable
        
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: LoginViewModeltype & Trackable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let input = LoginViewModel.Input()
        _ = viewModel.transform(input: input)
        
        viewModel.loading
            .drive()
            .disposed(by: disposeBag)

        viewModel.error
            .drive(rx.error)
            .disposed(by: disposeBag)
                
        usernameTextField.rx.text.bind(to: input.username).disposed(by: disposeBag)
        passwordTextField.rx.text.bind(to: input.password).disposed(by: disposeBag)
        loginButton.rx.tap.bind(to: input.loginAction).disposed(by: disposeBag)
        forgotPasswordButton.rx.tap.bind(to: input.forgotPasswordAction).disposed(by: disposeBag)
        registerButton.rx.tap.bind(to: input.registerAction).disposed(by: disposeBag)

    }
}


