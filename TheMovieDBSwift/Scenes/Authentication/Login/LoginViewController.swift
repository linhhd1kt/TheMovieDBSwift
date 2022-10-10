import RxSwift
import UIKit
import RxCocoa




final class LoginViewController: UIViewController {
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    
    private let viewModel: LoginViewModel
        
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let input = LoginViewModel.Input()
        viewModel.transform(input: input)
        
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


