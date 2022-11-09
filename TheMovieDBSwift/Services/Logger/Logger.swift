//
//  Logger.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 07/10/2022.
//

import Foundation
import Willow
import XCGLogger
import Network

protocol Logable {
    func verbose(_ message: String, functionName: StaticString, fileName: StaticString, lineNumber: Int)
    func debug(_ message: String, functionName: StaticString, fileName: StaticString, lineNumber: Int)
    func info(_ message: String, functionName: StaticString, fileName: StaticString, lineNumber: Int)
    func warn(_ message: String, functionName: StaticString, fileName: StaticString, lineNumber: Int)
    func error(_ message: String, functionName: StaticString, fileName: StaticString, lineNumber: Int)
    func severe(_ message: String, functionName: StaticString, fileName: StaticString, lineNumber: Int)
}

class Logger: Logable {
    var logger: XCGLogger = .default
    init() {
        #if DEBUG
        self.logger.setup(level: .info,
                          showThreadName: true,
                          showLevel: true,
                          showFileNames: true,
                          showLineNumbers: true,
                          writeToFile: nil,
                          fileLevel: .verbose)
        let emojiLogFormatter = PrePostFixLogFormatter()
        emojiLogFormatter.apply(prefix: "🇻🇳", postfix: "🇻🇳", to: .verbose)
        emojiLogFormatter.apply(prefix: "🔹", postfix: "🔹", to: .debug)
        emojiLogFormatter.apply(prefix: "ℹ️", postfix: "ℹ️", to: .info)
        emojiLogFormatter.apply(prefix: "⚠️", postfix: "⚠️", to: .warning)
        emojiLogFormatter.apply(prefix: "‼️", postfix: "‼️", to: .error)
        emojiLogFormatter.apply(prefix: "💣", postfix: "💣", to: .severe)
        self.logger.formatters = [emojiLogFormatter]
        #endif
    }
    func verbose(_ message: String,
                 functionName: StaticString = #function,
                 fileName: StaticString = #file,
                 lineNumber: Int = #line) {
        #if DEBUG
        self.logger.verbose(message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        #endif
    }
    
    func debug(_ message: String,
               functionName: StaticString = #function,
               fileName: StaticString = #file,
               lineNumber: Int = #line) {
        #if DEBUG
        self.logger.debug(message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        #endif
    }
    
    func info(_ message: String,
              functionName: StaticString = #function,
              fileName: StaticString = #file,
              lineNumber: Int = #line) {
        #if DEBUG
        self.logger.info(message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        #endif
    }
    
    func warn(_ message: String,
              functionName: StaticString = #function,
              fileName: StaticString = #file,
              lineNumber: Int = #line) {
        #if DEBUG
        self.logger.warning(message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        #endif
    }
    
    func error(_ message: String,
               functionName: StaticString = #function,
               fileName: StaticString = #file,
               lineNumber: Int = #line) {
        #if DEBUG
        self.logger.error(message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        #endif
    }
    
    func severe(_ message: String,
                functionName: StaticString = #function,
                fileName: StaticString = #file,
                lineNumber: Int = #line) {
        #if DEBUG
        self.logger.verbose(message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        #endif
    }
}

private var loggerContext: UInt8 = 3

protocol HasLogger: AnyObject {
    var logger: Logable { get set }
}

extension HasLogger {
    // swiftlint:disable type_contents_order
    func synchronizedLogger<T>(_ action: () -> T) -> T {
        objc_sync_enter(self)
        let result = action()
        objc_sync_exit(self)
        return result
    }

    public var logger: Logable {
        get {
            return synchronizedLogger {
                if let loggerObject = objc_getAssociatedObject(self, &loggerContext) as? Logable {
                    return loggerObject
                }
                let loggerObject = Logger()
                objc_setAssociatedObject(self, &loggerContext, loggerObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return loggerObject
            }
        }

        set {
            synchronizedLogger {
                objc_setAssociatedObject(self, &loggerContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
