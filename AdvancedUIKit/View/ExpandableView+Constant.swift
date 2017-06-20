/**
 * ExpandableView+Constant defines the constants related to an expandable view.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 19/06/2017
 */
extension ExpandableView {
    
    /**
     * System error.
     */
    static var superviewError: String {
        return "The superview is nil."
    }
    static var windowError: String {
        return"The window is nil."
    }
    
    /**
     * System warning.
     */
    static var expandWarning: String {
        return "The view cannot be expanded."
    }
    static var collapseWarning: String {
        return "The view cannot be collapsed."
    }
    
}
