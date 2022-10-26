//
//  ViewModel.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 22/09/2022.
//

import NSObject_Rx
import UIKit

class BaseViewModel: NSObject {
    var logger: Logger {
        guard let logger = ServiceFacade.getService(Logable.self) as? Logger else {
            fatalError("Logger should be implemented!")
        }
        return logger
    }
    
    override init() {
        super.init()
        logger.debug("\(className) is initialized.")
    }
    
    deinit {
        logger.debug("\(className) is release.")
    }
}

extension BaseViewModel: HasDisposeBag {}
