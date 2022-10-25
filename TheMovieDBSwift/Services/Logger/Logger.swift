//
//  Logger.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 07/10/2022.
//

import Foundation
import Willow
import XCGLogger

protocol Logable {
    func verbose(_ message: String)
    func debug(_ message: String)
    func info(_ message: String)
    func warn(_ message: String)
    func error(_ message: String)
    func severe(_ message: String)
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
                emojiLogFormatter.apply(prefix: "🇻🇳", postfix: nil, to: .verbose)
                emojiLogFormatter.apply(prefix: "🔹", postfix: nil, to: .debug)
                emojiLogFormatter.apply(prefix: "ℹ️", postfix: nil, to: .info)
                emojiLogFormatter.apply(prefix: "⚠️", postfix: nil, to: .warning)
                emojiLogFormatter.apply(prefix: "‼️", postfix: nil, to: .error)
                emojiLogFormatter.apply(prefix: "💣", postfix: nil, to: .severe)
            self.logger.formatters = [emojiLogFormatter]
        #endif
    }
    func verbose(_ message: String) {
        #if DEBUG
            self.logger.verbose(message)
        #endif
    }
    
    func debug(_ message: String) {
        #if DEBUG
            self.logger.debug(message)
        #endif
    }
    func info(_ message: String) {
        #if DEBUG
            self.logger.info(message)
        #endif
    }
    func warn(_ message: String) {
        #if DEBUG
            self.logger.warning(message)
        #endif
    }
    func error(_ message: String) {
        #if DEBUG
            self.logger.error(message)
        #endif
    }
    func severe(_ message: String) {
        #if DEBUG
            self.logger.severe(message)
        #endif
    }
}
