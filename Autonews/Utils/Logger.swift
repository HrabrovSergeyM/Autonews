//
//  Logger.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 09.07.2024.
//

import Foundation

class Logger {
    
    enum LogLevel: String {
        case info = "INFO"
        case warning = "WARNING"
        case error = "ERROR"
    }
    
    static let shared = Logger()
    
    private init() {}
    
    private var isLoggingEnabled: Bool = true
    private var logToFile: Bool = false
    private var logFileURL: URL? {
        if logToFile {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            return documentDirectory.appendingPathComponent("app.log")
        }
        return nil
    }
    
    func enableLogging(_ enable: Bool) {
        isLoggingEnabled = enable
    }
    
    func enableFileLogging(_ enable: Bool) {
        logToFile = enable
    }
    
    func log(_ message: String, level: LogLevel = .info, file: String = #file, function: String = #function, line: Int = #line) {
        guard isLoggingEnabled else { return }
        
        let fileName = (file as NSString).lastPathComponent
        let logMessage = "\(Date()): [\(level.rawValue)] \(message) \nFile: \(fileName) \nFunction: \(function) \nLine: \(line)\n"
        
        if logToFile, let logFileURL = logFileURL {
            logToFile(logMessage, fileURL: logFileURL)
        } else {
            print(logMessage)
        }
    }
    
    func logError(_ errorMessage: ErrorMessage, file: String = #file, function: String = #function, line: Int = #line) {
        log(errorMessage.rawValue, level: .error, file: file, function: function, line: line)
    }
    
    private func logToFile(_ message: String, fileURL: URL) {
        do {
            let fileHandle = try FileHandle(forWritingTo: fileURL)
            fileHandle.seekToEndOfFile()
            if let data = message.data(using: .utf8) {
                fileHandle.write(data)
            }
            fileHandle.closeFile()
        } catch {
            do {
                try message.write(to: fileURL, atomically: true, encoding: .utf8)
            } catch {
                print("Failed to log to file: \(error)")
            }
        }
    }
}

enum ErrorMessage: String {
    case invalidURL = "Invalid URL"
    case failedToEncode = "Failed to encode data"
}
