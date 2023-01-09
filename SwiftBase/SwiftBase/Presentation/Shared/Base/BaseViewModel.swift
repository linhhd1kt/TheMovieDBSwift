//
//  ViewModel.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Design
import Extension

open class BaseViewModel: NSObject {
//    var logger: Logger {
//        guard let logger = ServiceFacade.getService(Logable.self) as? Logger else {
//            fatalError("Logger should be implemented!")
//        }
//        return logger
//    }

  override public init() {
    super.init()
//        logger.debug("\(className) is initialized.")
  }

  deinit {
//        logger.debug("\(className) is release.")
  }
}

extension BaseViewModel: HasDisposeBag {}
