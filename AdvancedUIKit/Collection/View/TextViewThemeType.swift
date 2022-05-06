/// TextViewThemeType defines the theme of a text view
///
/// - version: 1.8.0
/// - date: 04/05/22
/// - author: Adamas
public protocol TextViewThemeType {
    var normalColor: UIColor { get }
    var highlightedColor: UIColor { get }
    var errorColor: UIColor { get }
    var textColor: UIColor { get }
    var placeholderColor: UIColor { get }
}

import UIKit
