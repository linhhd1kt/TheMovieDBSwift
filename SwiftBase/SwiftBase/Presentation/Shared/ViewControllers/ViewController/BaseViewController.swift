//
//  ViewController.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Action
import PopupDialog
import RxSwift
import Extension
import Services
import Design

open class BaseViewController: UIViewController {
  open override var preferredStatusBarStyle: UIStatusBarStyle {
    return design.userInterFaceStyle == .dark ? .darkContent : .lightContent
  }
  fileprivate var okActionObserver = PublishSubject<Void>()
  fileprivate var cancelActionObserber = PublishSubject<Void>()
  
  private var design: DesignType {
    guard let design = ServiceFacade.getService(DesignType.self) else {
      fatalError("Design should be implemented!")
    }
    return design
  }
  
  private var logger: LoggerType {
    guard let logger = ServiceFacade.getService(LoggerType.self) else {
      fatalError("Logger should be implemented!")
    }
    return logger
  }
  
  public required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public init() {
    super.init(nibName: nil, bundle: nil)
    logger.debug("\(self.className) is initialized.", functionName: #function, fileName: #file, lineNumber: #line)
  }

  override open func viewDidLoad() {
    super.viewDidLoad()
    overrideUserInterfaceStyle = design.userInterFaceStyle
  }

  deinit {
    logger.debug("\(self.className) is release.", functionName: #function, fileName: #file, lineNumber: #line)
  }
}

extension BaseViewController: HasDisposeBag {}

public extension Reactive where Base: BaseViewController {
  var showError: Binder<ActionError> {
    return Binder(base) { view, actionError in
      var message: String
      switch actionError {
      case .notEnabled:
        message = "Action Not Enabled"
      case let .underlyingError(error):
        message = error.localizedDescription
      }
      let alert = AlertController()

      let popup = PopupDialog(viewController: alert,
                              buttonAlignment: .horizontal,
                              transitionStyle: .bounceUp,
                              preferredWidth: 320,
                              tapGestureDismissal: true,
                              panGestureDismissal: true,
                              hideStatusBar: false,
                              completion: nil)
      let okButton = DefaultButton(title: "OK", dismissOnTap: true) {}
      popup.addButton(okButton)
      view.present(popup, animated: true)
      alert.set(message)
    }
  }

  var showConfirm: Binder<ActionError> {
    return Binder(base) { view, actionError in
      var message: String
      switch actionError {
      case .notEnabled:
        message = "Action Not Enabled"
      case let .underlyingError(error):
        message = error.localizedDescription
      }
      let alert = AlertController()

      let popup = PopupDialog(viewController: alert,
                              buttonAlignment: .horizontal,
                              transitionStyle: .bounceUp,
                              preferredWidth: 320,
                              tapGestureDismissal: true,
                              panGestureDismissal: true,
                              hideStatusBar: false,
                              completion: nil)
      let okButton = DefaultButton(title: "OK", dismissOnTap: true) { base.okActionObserver.onNext(())
      }
      popup.addButton(okButton)
      let cancelButton = DefaultButton(title: "Cancel", dismissOnTap: true) { base.cancelActionObserber.onNext(())
      }
      popup.addButton(cancelButton)
      view.present(popup, animated: true)
      alert.set(message)
    }
  }

  var onConfirmOK: Observable<Void> {
    return base.okActionObserver.asObservable()
  }

  var onConfirmCancel: Observable<Void> {
    return base.cancelActionObserber.asObservable()
  }
}

public extension UIViewController {
  var moduleName: String {
    let object = NSStringFromClass(classForCoder) as NSString
    guard let moduleName = object.components(separatedBy: ".").first else {
      fatalError("Could not get module name")
    }
    return moduleName
  }

  static func loadFromNib() -> Self {
    func instantiateFromNib<T: UIViewController>() -> T {
      return T(nibName: String(describing: T.self), bundle: nil)
    }

    return instantiateFromNib()
  }
}
