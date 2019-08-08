/// UIButton+Dynamic contains dynamic content of a label.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 08/08/2019
public extension UIButton {
    
    /// Get the height of each line.
    var lineHeight: CGFloat {
        guard let titleLabel = titleLabel else {
            Logger.standard.logWarning(UIButton.titleLabelWarning)
            return 0
        }
        return titleLabel.lineHeight
    }
    
    /// How many lines are presented.
    var lineAmount: Int {
        guard let titleLabel = titleLabel else {
            Logger.standard.logWarning(UIButton.titleLabelWarning)
            return 0
        }
        return titleLabel.lineAmount
    }
    
    /// The actual height of the text.
    var actualHeight: CGFloat {
        guard let titleLabel = titleLabel else {
            Logger.standard.logWarning(UIButton.titleLabelWarning)
            return 0
        }
        return titleLabel.actualHeight
    }
}

/// Constants
private extension UIButton {
    
    /// System warning.
    static let titleLabelWarning = "The title label is nil."
}

import AdvancedFoundation
import UIKit
