//
//  Logger.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import XCGLogger

public enum LogLevel: Int, CaseIterable, CustomStringConvertible {
  case verbose
  case debug
  case info
  case notice
  case warning
  case error
  case severe // aka critical
  case alert
  case emergency
  case none
  
  public var description: String {
    switch self {
    case .verbose:
      return "Verbose"
    case .debug:
      return "Debug"
    case .info:
      return "Info"
    case .notice:
      return "Notice"
    case .warning:
      return "Warning"
    case .error:
      return "Error"
    case .severe:
      return "Severe"
    case .alert:
      return "Alert"
    case .emergency:
      return "Emergency"
    case .none:
      return "None"
    }
  }
}

public protocol LoggerType {
  func verbose(_ message: String, functionName: StaticString, fileName: StaticString, lineNumber: Int)
  func debug(_ message: String, functionName: StaticString, fileName: StaticString, lineNumber: Int)
  func info(_ message: String, functionName: StaticString, fileName: StaticString, lineNumber: Int)
  func warn(_ message: String, functionName: StaticString, fileName: StaticString, lineNumber: Int)
  func error(_ message: String, functionName: StaticString, fileName: StaticString, lineNumber: Int)
  func severe(_ message: String, functionName: StaticString, fileName: StaticString, lineNumber: Int)
  func getLogLevel() -> LogLevel
  func setLogLevel(_ logLevel: LogLevel)
}

public class Logger: LoggerType {
  private var logger: XCGLogger = .default
  private var shouldTrackWithFireBase = false
  
  public init() {
    logger.setup(level: .verbose,
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
    logger.formatters = [emojiLogFormatter]
  }
  
  public func verbose(_ message: String,
                      functionName: StaticString = #function,
                      fileName: StaticString = #file,
                      lineNumber: Int = #line) {
    logger.verbose(message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
  }
  
  public func debug(_ message: String,
                    functionName: StaticString = #function,
                    fileName: StaticString = #file,
                    lineNumber: Int = #line) {
    logger.verbose(message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
  }
  
  public func info(_ message: String,
                   functionName: StaticString = #function,
                   fileName: StaticString = #file,
                   lineNumber: Int = #line) {
    logger.info(message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
  }
  
  public func warn(_ message: String,
                   functionName: StaticString = #function,
                   fileName: StaticString = #file,
                   lineNumber: Int = #line) {
    logger.warning(message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
  }
  
  public func error(_ message: String,
                    functionName: StaticString = #function,
                    fileName: StaticString = #file,
                    lineNumber: Int = #line) {
    logger.error(message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
  }
  
  public func severe(_ message: String,
                     functionName: StaticString = #function,
                     fileName: StaticString = #file,
                     lineNumber: Int = #line) {
    logger.severe(message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
  }
  
  public func getLogLevel() -> LogLevel {
    return LogLevel(rawValue: logger.outputLevel.rawValue) ?? .none
  }
  
  public func setLogLevel(_ logLevel: LogLevel) {
    let level = XCGLogger.Level(rawValue: logLevel.rawValue) ?? .none
    logger.outputLevel = level
  }
}
