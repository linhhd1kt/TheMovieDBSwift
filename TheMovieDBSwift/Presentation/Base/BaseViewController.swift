//
//  ViewController.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 22/09/2022.
//

import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx

class BaseViewController: UIViewController {
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
        logger.debug("\(className) is initialized.")
    }
    deinit {
        logger.debug("\(className) is release.")
    }
}

extension BaseViewController: HasDisposeBag {}
