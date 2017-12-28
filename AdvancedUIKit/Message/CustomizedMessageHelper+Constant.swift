/// CustomizedMessageHelper+Constant defines all constants used by CustomizedMessageHelper.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 14/09/2017
extension CustomizedMessageHelper {
    
    /// Error message.
    @objc static let typeError = "The message type is unknown."
    
    /// The margin of the customized message content.
    @objc static let padding = CGFloat(10)
    
    /// The default background color of the message view.
    @objc static let defaultMessageBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    
    /// The default background color of the mask view.
    @objc static let defaultMaskBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
    
    /// The default background color of the input view.
    @objc static let defaultInputPlaceHolderColor = UIColor(white: 1, alpha: 0.2)
    
    /// The default separator color of the message view.
    @objc static let defaultSeperatorColor = UIColor.white
    
    /// The default text color.
    @objc static let defaultTextColor = UIColor.white
    
    /// The radius of the message box.
    @objc static let radius = CGFloat(5)
    
    /// The width weight of a customized message compared to the window width.
    @objc static let widthWeight = CGFloat(0.7)
    
    /// The maximal height weight of a customized message  compared to the height of the window.
    @objc static let maxHeightWeight = CGFloat(0.6)
    
}

import UIKit
