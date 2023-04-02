/// TextAreaView defines a view that has a text view
///
/// - version: 1.8.0
/// - date: 06/05/22
/// - author: Adamas
open class TextAreaView<Row: TextRowType>: View<Row>, UITextViewDelegate {
    /// Outlet
    @IBOutlet private var hintLabel: UILabel!
    @IBOutlet private var textView: UITextView! {
        didSet {
            textView?.borderWidth = Self.borderWidth
            textView?.contentInset = Self.textInset
        }
    }
    
    /// Set the accessory view of the text field
    public var inputTextFieldAccessoryView: UIView? {
        didSet {
            textView?.inputAccessoryView = inputTextFieldAccessoryView
        }
    }
    
    /// Get the current text on the screen
    public var text: String? {
        textView?.text
    }
    
    /// Set the theme of the text view
    public var theme: TextViewThemeType?
    
    /// Reset the view to the normal state
    public func reset() {
        textView?.text = nil
        let normalColor = theme?.normalColor ?? Self.defaultNormalColor
        textView.borderColor = normalColor
        titleLabel?.textColor = normalColor
        hintLabel.textColor = normalColor
        hintLabel.text = .space
    }
    
    @discardableResult
    open override func becomeFirstResponder() -> Bool {
        textView?.becomeFirstResponder()
        return super.becomeFirstResponder()
    }
    
    public override func configure(with row: RowType) {
        guard let row = row as? Row else {
            let rowError = String(format: Self.rowErrorPattern,
                                  String(describing: Row.self),
                                  String(describing: row))
            fatalError(rowError)
        }
        super.configure(with: row)
        textView.returnKeyType = row.returnType
        textView.keyboardType = row.keyboardType
        reset()
        
        self.row?.reloadAction = { [weak self] in
            guard let self = self,
                  let row = self.row else {
                return
            }
            self.isHidden = row.isHidden
            self.textView.text = row.value
        }
        self.row?.reloadAction?()
        _ = row.isValid(value: textView.text, shouldUpdateView: false)
        applyPlaceholderIfNecessary()
    }
    
    private func applyPlaceholderIfNecessary() {
        if textView.text.isEmpty != false {
            textView.text = row?.placeholder
            textView.textColor = theme?.placeholderColor ?? Self.defaultPlaceholderColor
        }
    }
    
    public func textView(_ textView: UITextView,
                         shouldChangeTextIn range: NSRange,
                         replacementText: String) -> Bool {
        guard replacementText != .linebreak else {
            textView.resignFirstResponder()
            row?.didReturnAction?()
            return false
        }
        let currentValue = textView.text ?? .empty
        guard let range = Range(range, in: currentValue) else {
            return false
        }
        let newValue = currentValue.replacingCharacters(in: range, with: replacementText)
        _ = row?.isValid(value: newValue, shouldUpdateView: false)
        return true
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        let highlightedColor = theme?.highlightedColor ?? Self.defaultHighlightedColor
        titleLabel?.textColor = highlightedColor
        textView.borderColor = highlightedColor
        hintLabel.textColor = theme?.normalColor ?? Self.defaultNormalColor
        hintLabel.text = .space
        if textView.text == row?.placeholder {
            textView.text = nil
            textView.textColor = theme?.textColor ?? Self.defaultTextColor
        }
        row?.didStartEditingAction?()
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        hintLabel.text = row?.isValid(value: textView.text, shouldUpdateView: false)
        let color = row?.isValid == true
        ? theme?.normalColor ?? Self.defaultNormalColor
        : theme?.errorColor ?? Self.defaultErrorColor
        titleLabel?.textColor = color
        textView.borderColor = color
        hintLabel.textColor = color
        applyPlaceholderIfNecessary()
        row?.didEndEditingAction?()
    }
}

/// Constants
private extension TextAreaView {
    
    private static var defaultHighlightedColor: UIColor { .black }
    private static var defaultNormalColor: UIColor { .gray }
    private static var defaultErrorColor: UIColor { .red }
    private static var defaultTextColor: UIColor { .black }
    private static var defaultPlaceholderColor: UIColor { .gray }

    private static var textInset: UIEdgeInsets { UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 12) }
    private static var borderWidth: CGFloat { 1 }
}

import UIKit
