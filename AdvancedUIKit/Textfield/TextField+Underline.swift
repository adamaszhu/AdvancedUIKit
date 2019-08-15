/// TextField+Underline add underline support for a text field.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 15/08/2019
public extension UITextField {
    
    /// The underline view.
    private var underlineView: UnderlineView? {
        return subviews.first { $0 is UnderlineView } as? UnderlineView
    }
    
    /// Activate the underline view.
    ///
    /// - Parameters:
    ///   - color: The normal color of the underline.
    ///   - highlightedColor: The highlighted color of the underline.
    func activateUnderline(withNormal color: UIColor, withHignlighted highlightedColor: UIColor) {
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
    func deactivateUnderline() {
        guard let underlineView = underlineView else {
            Logger.standard.logError(UITextField.activationError)
            return
        }
        underlineView.removeFromSuperview()
    }
    
    /// Start editing and highlight the underline view.
    @objc func startEditing() {
        underlineView?.isHighlighted = true
    }
    
    /// Finish the editing and dehighlight the underline view.
    @objc func finishEditing() {
        underlineView?.isHighlighted = false
    }
}

/// Constants
private extension UITextField {
    
    /// The default height of the underline.
    private static let defaultUnderlineHeight: CGFloat = 1
    
    /// System error.
    private static let activationError = "The underline has been activated."
}

import AdvancedFoundation
import UIKit
