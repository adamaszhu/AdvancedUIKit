/// TextField+Underline add underline support for a text field.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 05/06/2017
public extension UITextField {
    
    /// The default height of the underline.
    private static let defaultUnderlineHeight = CGFloat(1)
    
    /// System error.
    private static let activationError = "The underline has been activated."
    
    /// The underline view.
    internal var underlineView: UnderlineView? {
        for view in subviews {
            if let underlineView = view as? UnderlineView {
                return underlineView
            }
        }
        return nil
    }
    
    /// Activate the underline view.
    ///
    /// - Parameters:
    ///   - color: The normal color of the underline.
    ///   - highlightedColor: The highlighted color of the underline.
    public func activateUnderline(withNormal color: UIColor, withHignlighted highlightedColor: UIColor) {
        guard underlineView == nil else {
            Logger.standard.logError(UITextField.activationError)
            return
        }
        let newUnderlineView = UnderlineView(frame: CGRect(x: 0, y: frame.height - UITextField.defaultUnderlineHeight, width: frame.width, height: UITextField.defaultUnderlineHeight))
        addSubview(newUnderlineView)
        newUnderlineView.color = color
        newUnderlineView.highlightedColor = highlightedColor
        newUnderlineView.isHighlighted = false
        addTarget(self, action: #selector(startEditing), for: .editingDidBegin)
        addTarget(self, action: #selector(finishEditing), for: .editingDidEnd)
    }
    
    /// Deactivate the underline view.
    public func deactivateUnderline(withNormal color: UIColor, withHignlighted highlightedColor: UIColor) {
        guard let underlineView = underlineView else {
            Logger.standard.logError(UITextField.activationError)
            return
        }
        underlineView.removeFromSuperview()
    }
    
    /// Start editing and highlight the underline view.
    func startEditing() {
        underlineView?.isHighlighted = true
    }
    
    /// Finish the editing and dehighlight the underline view.
    func finishEditing() {
        underlineView?.isHighlighted = false
    }
    
}

import UIKit
