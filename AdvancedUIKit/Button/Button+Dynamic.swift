/// UIButton+Dynamic contains dynamic content of a label.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 31/05/2017
public extension UIButton {
    
    /// System warning.
    private static let titleLabelWarning = "The title label is nil."
    
    /// Get the height of each line.
    public var lineHeight: CGFloat {
        guard let titleLabel = titleLabel else {
            Logger.standard.log(warning: UIButton.titleLabelWarning)
            return 0
        }
        return titleLabel.lineHeight
    }
    
    /// How many lines are presented.
    public var lineAmount: Int {
        guard let titleLabel = titleLabel else {
            Logger.standard.log(warning: UIButton.titleLabelWarning)
            return 0
        }
        return titleLabel.lineAmount
    }
    
    /// The actual height of the text.
    public var actualHeight: CGFloat {
        guard let titleLabel = titleLabel else {
            Logger.standard.log(warning: UIButton.titleLabelWarning)
            return 0
        }
        return titleLabel.actualHeight
    }
    
}

import UIKit


