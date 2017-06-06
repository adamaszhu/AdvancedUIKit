/**
 * Logger is used to format a log.
 * - author: Adamas
 * - version: 1.0.1
 * - date: 11/04/2017
 */
class Logger {
    
    /**
     * The default logger.
     */
    static let standard: Logger = Logger()
    
    /**
     * Message tag.
     */
    private static let errorTag = "Error"
    private static let infoTag = "Info"
    private static let warningTag = "Warning"
    private static let detailSeperator = "=========="
    
    /**
     * The date format.
     */
    private static let dateFormat = "yyyy/MM/dd HH:mm:ss.SSS"
    
    /**
     * Log an info.
     * - parameter info: The info.
     * - parameter detail: The detail of the info.
     */
    func logInfo(_ info: String, withDetail detail: Any? = nil) {
        logMessage(info, withTag: Logger.infoTag, withDetail: detail)
    }
    
    /**
     * Log a warning.
     * - parameter warning: The warning.
     * - parameter detail: The detail of the warning.
     */
    func logWarning(_ warning: String, withDetail detail: Any? = nil) {
        logMessage(warning, withTag: Logger.warningTag, withDetail: detail)
    }
    
    /**
     * Log an error.
     * - parameter error: The error.
     * - parameter detail: The detail of the error.
     */
    func logError(_ error: String, withDetail detail: Any? = nil) {
        logMessage(error, withTag: Logger.errorTag, withDetail: detail)
    }
    
    /**
     * Log an error.
     * - parameter error: The error.
     */
    func logError(_ error: Error) {
        logMessage(error.localizedDescription, withTag: Logger.errorTag)
    }
    
    /**
     * Log a message.
     * - parameter tag: The type of the message.
     * - parameter message: The message.
     */
    private func logMessage(_ message: String, withTag tag: String, withDetail detail: Any? = nil) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Logger.dateFormat
        let dateString = dateFormatter.string(from: date)
        if let detail = detail {
            print("\(tag) \(dateString): \(message)\n\(Logger.detailSeperator)\n\(detail)\n\(Logger.detailSeperator)")
        } else {
            print("\(tag) \(dateString): \(message)")
        }
    }
    
}

import Foundation
