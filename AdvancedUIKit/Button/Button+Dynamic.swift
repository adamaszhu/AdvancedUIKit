/// UIButton+Dynamic contains dynamic content of a label.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 31/05/2017
public extension UIButton {
    
    /// System warning.
    private static let titleLabelWarning = "The title label is nil."
    
    /// Get the height of each line.
    @objc var lineHeight: CGFloat {
        guard let titleLabel = titleLabel else {
            Logger.standard.logWarning(UIButton.titleLabelWarning)
            return 0
        }
        return titleLabel.lineHeight
    }
    
    /// How many lines are presented.
    @objc var lineAmount: Int {
        guard let titleLabel = titleLabel else {
            Logger.standard.logWarning(UIButton.titleLabelWarning)
            return 0
        }
        return titleLabel.lineAmount
    }
    
    /// The actual height of the text.
    @objc var actualHeight: CGFloat {
        guard let titleLabel = titleLabel else {
            Logger.standard.logWarning(UIButton.titleLabelWarning)
            return 0
        }
        return titleLabel.actualHeight
    }
    
}

import UIKit


