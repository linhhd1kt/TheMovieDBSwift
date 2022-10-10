//
//  Logger.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 07/10/2022.
//

import Foundation
import Willow

enum LogingLevel {
    case off
    case debug
    case info
    case warn
    case error
}

extension Logger {
    func convert(logingLevel: LogingLevel) -> LogLevel  {
        switch logingLevel {
        case .off:
            return LogLevel.off
        case .debug:
            return LogLevel.debug
        case .info:
            return LogLevel.info
        case .warn:
            return LogLevel.warn
        case .error:
            return LogLevel.error
        }
    }
}

protocol Logable {
    func debug(_ message: String)
    func info(_ message: String)
    func warn(_ message: String)
    func error(_ message: String)
}

class ELogger: Logable {
    var logger: Logger
    
    init(logger: Logger = Logger(logLevels: [.all], writers: [ConsoleWriter()])) {
        self.logger = logger
    }
    
    func debug(_ message: String) {
        self.logger.debugMessage(message)
    }
    func info(_ message: String) {
        self.logger.infoMessage(message)
    }
    func warn(_ message: String) {
        self.logger.warnMessage(message)
    }
    func error(_ message: String) {
        self.logger.errorMessage(message)
    }
}
