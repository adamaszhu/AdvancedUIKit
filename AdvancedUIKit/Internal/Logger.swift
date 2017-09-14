/// Logger is used to format a log.
/// - author: Adamas
/// - version: 1.1.0
/// - date: 12/09/2017
final class Logger {
    
    /// Message tags.
    private static let errorTag = "Error"
    private static let infoTag = "Info"
    private static let warningTag = "Warning"
    private static let detailSeperator = "=========="
    
    /// The date format.
    private static let dateFormat = "yyyy/MM/dd HH:mm:ss.SSS"
    
    /// The default logger.
    static let standard: Logger = .init()
    
    /// Log an info.
    ///
    /// - Parameters:
    ///   - info: The info.
    ///   - detail: The detail of the info.
    func log(info: String, withDetail detail: Any? = nil) {
        log(message: info, withTag: Logger.infoTag, withDetail: detail)
    }
    
    /// Log a warning.
    ///
    /// - Parameters:
    ///   - warning: The warning.
    ///   - detail: The detail of the warning.
    func log(warning: String, withDetail detail: Any? = nil) {
        log(message: warning, withTag: Logger.warningTag, withDetail: detail)
    }
    
    /// Log an error.
    ///
    /// - Parameters:
    ///   - error: The error.
    ///   - detail: The detail of the error.
    func log(error: String, withDetail detail: Any? = nil) {
        log(message: error, withTag: Logger.errorTag, withDetail: detail)
    }
    
    /// Log an error.
    ///
    /// - Parameter error: The error.
    func log(_ error: Error) {
        log(message: error.localizedDescription, withTag: Logger.errorTag)
    }
    
    /// Log a message.
    ///
    /// - Parameters
    ///   - tag: The type of the message.
    ///   - message: The message.
    ///   - detail: The detail of the message.
    private func log(message: String, withTag tag: String, withDetail detail: Any? = nil) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Logger.dateFormat
        let dateString = dateFormatter.string(from: date)
        var log = "\(tag) \(dateString): \(message)"
        if let detail = detail {
            log = log + "\n\(Logger.detailSeperator)\n\(detail)\n\(Logger.detailSeperator)"
        }
        print(log)
    }
    
}

import Foundation
