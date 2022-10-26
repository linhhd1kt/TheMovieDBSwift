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
        self.logger.setup(level: .verbose,
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
        self.logger.verbose(functionName, fileName: fileName, lineNumber: lineNumber, userInfo: ["message": message])
        #endif
    }
    
    func debug(_ message: String,
               functionName: StaticString = #function,
               fileName: StaticString = #file,
               lineNumber: Int = #line) {
        #if DEBUG
        self.logger.debug(functionName, fileName: fileName, lineNumber: lineNumber, userInfo: ["message": message])
        #endif
    }
    
    func info(_ message: String,
              functionName: StaticString = #function,
              fileName: StaticString = #file,
              lineNumber: Int = #line) {
        #if DEBUG
        self.logger.info(functionName, fileName: fileName, lineNumber: lineNumber, userInfo: ["message": message])
        #endif
    }
    
    func warn(_ message: String,
              functionName: StaticString = #function,
              fileName: StaticString = #file,
              lineNumber: Int = #line) {
        #if DEBUG
        self.logger.warning(functionName, fileName: fileName, lineNumber: lineNumber, userInfo: ["message": message])
        #endif
    }
    
    func error(_ message: String,
               functionName: StaticString = #function,
               fileName: StaticString = #file,
               lineNumber: Int = #line) {
        #if DEBUG
        self.logger.error(functionName, fileName: fileName, lineNumber: lineNumber, userInfo: ["message": message])
        #endif
    }
    
    func severe(_ message: String,
                functionName: StaticString = #function,
                fileName: StaticString = #file,
                lineNumber: Int = #line) {
        #if DEBUG
        self.logger.severe(functionName, fileName: fileName, lineNumber: lineNumber, userInfo: ["message": message])
        #endif
    }
}
