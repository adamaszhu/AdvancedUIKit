/**
 * NSObject+Log is used to format a log.
 * - author: Adamas
 * - version: 1.0.0
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
    private let errorTag = "Error"
    private let infoTag = "Info"
    private let detailSeperator = "=========="
    
    /**
     * The date format.
     */
    private let dateFormat = "yyyy/MM/dd HH:mm:ss.SSS"
    
    /**
     * Log an info.
     * - parameter info: The info.
     * - parameter detail: The detail of the error.
     */
    func logInfo(_ info: String, withDetail detail: Any? = nil) {
        logMessage(info, withTag: infoTag, withDetail: detail)
    }
    
    /**
     * Log an error.
     * - parameter error: The error.
     * - parameter detail: The detail of the error.
     */
    func logError(_ error: String, withDetail detail: Any? = nil) {
        logMessage(error, withTag: errorTag, withDetail: detail)
    }
    
    /**
     * Log an error.
     * - parameter error: The error.
     */
    func logError(_ error: Error) {
        logMessage(error.localizedDescription, withTag: errorTag)
    }
    
    /**
     * Log a message.
     * - parameter tag: The type of the message.
     * - parameter message: The message.
     */
    private func logMessage(_ message: String, withTag tag: String, withDetail detail: Any? = nil) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let dateString = dateFormatter.string(from: date)
        if detail == nil {
            print("\(tag) \(dateString): \(message)")
        } else {
            print("\(tag) \(dateString): \(message)\n\(detailSeperator)\n\(detail!)\n\(detailSeperator)")
        }
    }
    
}

import Foundation
