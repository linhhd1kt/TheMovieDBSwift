//
//  ViewModel.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Design
import Extension
import Services

open class BaseViewModel: NSObject {
    var logger: LoggerType {
        guard let logger = ServiceFacade.getService(LoggerType.self) as? Logger else {
            fatalError("Logger should be implemented!")
        }
        return logger
    }

  override public init() {
    super.init()
    logger.debug("\(className) is initialized.", functionName: #function, fileName: #file, lineNumber: #line)
  }

  deinit {
    logger.debug("\(className) is release.", functionName: #function, fileName: #file, lineNumber: #line)
  }
}

extension BaseViewModel: HasDisposeBag {}
