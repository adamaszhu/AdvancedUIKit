/// Logger is used to format a log.
/// - author: Adamas
/// - version: 1.5.0
/// - date: 08/05/2019
public class Logger {
    
    /// The default logger.
    public static let standard = Logger()
    
    /// Log an info.
    ///
    /// - Parameters:
    ///   - info: The info.
    ///   - detail: The detail of the info.
    func logInfo(_ info: String, withDetail detail: Any? = nil) {
        logMessage(info, withTag: Logger.infoTag, withDetail: detail)
    }
    
    /// Log a warning.
    ///
    /// - Parameters:
    ///   - warning: The warning.
    ///   - detail: The detail of the warning.
    func logWarning(_ warning: String, withDetail detail: Any? = nil) {
        logMessage(warning, withTag: Logger.warningTag, withDetail: detail)
    }
    
    /// Log an error.
    ///
    /// - Parameters:
    ///   - error: The error.
    ///   - detail: The detail of the error.
    func logError(_ error: String, withDetail detail: Any? = nil) {
        logMessage(error, withTag: Logger.errorTag, withDetail: detail)
    }
    
    /// Log an error.
    ///
    /// - Parameter error: The error.
    func log(_ error: Error) {
        logMessage(error.localizedDescription, withTag: Logger.errorTag)
    }
    
    /// Log a message.
    ///
    /// - Parameters
    ///   - tag: The type of the message.
    ///   - message: The message.
    ///   - detail: The detail of the message.
    private func logMessage(_ message: String, withTag tag: String, withDetail detail: Any? = nil) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Logger.dateFormat
        let dateString = dateFormatter.string(from: date)
        var log = String(format: Logger.logPattern, tag, dateString, message)
        if let detail = detail {
            let detailString = "\(detail)"
            log = String(format: Logger.detailPattern, log, detailString)
        }
        print(log)
    }
}

/// Constants
private extension Logger {
    
    /// The date format.
    static let dateFormat = "yyyy/MM/dd HH:mm:ss.SSS"
    
    /// The log pattern as "\(tag) \(dateString): \(message)".
    static let logPattern = "%@ %@: %@"
    
    /// The detail pattern as "\(log)\n==========\n\(detail)\n==========".
    static let detailPattern = "%@\n\(Logger.detailSeperator)\n%@\n\(Logger.detailSeperator)"
    
    /// Message tags.
    static let errorTag = "Error"
    static let infoTag = "Info"
    static let warningTag = "Warning"
    static let detailSeperator = "=========="
}

import Foundation
