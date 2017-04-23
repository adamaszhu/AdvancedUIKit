/**
 * NSObject+Log is used to format a log.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 11/04/2017
 */
class Logger: AnyObject {
    
    /**
     * Message tag.
     */
    private static let errorTag = "Error"
    private static let infoTag = "Info"
    private static let detailSeperator = "=========="
    
    /**
     * Log an info.
     * - parameter info: The info.
     * - parameter detail: The detail of the error.
     */
    static func logInfo(_ info: String, withDetail detail: Any? = nil) {
        logMessage(info, withTag: infoTag, withDetail: detail)
    }
    
    /**
     * Log an error.
     * - parameter error: The error.
     * - parameter detail: The detail of the error.
     */
    static func logError(_ error: String, withDetail detail: Any? = nil) {
        logMessage(error, withTag: errorTag, withDetail: detail)
    }
    
    /**
     * Log a message.
     * - parameter tag: The type of the message.
     * - parameter message: The message.
     */
    static func logMessage(_ message: String, withTag tag: String, withDetail detail: Any? = nil) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss.SSS"
        let dateString = dateFormatter.string(from: date)
        if detail == nil {
            print("\(tag) \(dateString): \(message)")
        } else {
            print("\(tag) \(dateString): \(message)\n\(detailSeperator)\n\(detail!)\n\(detailSeperator)")
        }
    }
    
}

import Foundation
