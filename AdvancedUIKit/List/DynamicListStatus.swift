import Foundation

/**
 * DynamicListStatus represents the status of a DynamicList.
 * - version: 0.0.1
 * - date: 23/10/2016
 * - author: Adamas
 */
enum DynamicListStatus {
    case Initial
    case Idle
    case LoadingMore
    case Reloading
}
