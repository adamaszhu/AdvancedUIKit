/// ImageView+Animation provides a shortcut for creating animations using an image view
///
/// - author: Adamas
/// - date: 17/08/2019
/// - version: 1.5.0
public extension UIImageView {
    
    /// Set a set of images.
    ///
    /// - Parameters:
    ///   - pattern: The pattern of the image.
    ///   - startIndex: The start index of the image set. Default is 0.
    ///   - endIndex: The end index of the image set.
    func setImages(withPattern pattern: String, fromIndex startIndex: Int = 0, toIndex endIndex: Int) {
        guard pattern.contains(UIImageView.indexPlaceholder) else {
            Logger.standard.logError(UIImageView.patternError)
            return
        }
        var images = [UIImage?]()
        for index in startIndex...endIndex {
            let name = String(format: pattern, index)
            let image = UIImage(named: name)
            images.append(image)
        }
        animationImages = images.compactMap { $0 }
    }
}

/// Constants
private extension UIImageView {
    
    /// The placeholder.
    static let indexPlaceholder = "%d"
    
    /// System error.
    static let patternError = "The pattern is incorrect."
}

import AdvancedFoundation
import UIKit
