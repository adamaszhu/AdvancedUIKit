/// TextView defines a view that has a text field
///
/// - version: 1.8.0
/// - date: 04/05/22
/// - author: Adamas
open class TextView<Row: TextRowType>: View<Row>, UITextFieldDelegate {
    /// Outlets
    @IBOutlet private var textField: UITextField?
    @IBOutlet private var hintLabel: UILabel?
    @IBOutlet private var lineView: UIView?
    @IBOutlet private var leadingConstraint: NSLayoutConstraint?

    /// Set the accessory view of the text field
    public var inputTextFieldAccessoryView: UIView? {
        didSet {
            textField?.inputAccessoryView = inputTextFieldAccessoryView
        }
    }

    /// Get the current text on the screen
    public var text: String? {
        textField?.text
    }

    /// Set the theme of the text view
    public var theme: TextViewThemeType?

    /// Display an external hint immediately
    ///
    /// - Parameter hint: The hint message
    public func setExternalHint(_ hint: String) {
        hintLabel?.text = hint
        let errorColor = theme?.errorColor ?? Self.defaultErrorColor
        titleLabel?.textColor = errorColor
        lineView?.backgroundColor = errorColor
        hintLabel?.textColor = errorColor
    }

    /// Reset the view to the normal state
    public func reset() {
        textField?.text = nil
        let normalColor = theme?.normalColor ?? Self.defaultNormalColor
        titleLabel?.textColor = normalColor
        lineView?.backgroundColor = normalColor
        hintLabel?.textColor = normalColor
        hintLabel?.text = .empty
    }

    @discardableResult
    open override func becomeFirstResponder() -> Bool {
        textField?.becomeFirstResponder()
        return super.becomeFirstResponder()
    }

    open override func configure(with row: RowType) {
        guard let row = row as? Row else {
            let rowError = String(format: Self.rowErrorPattern,
                                  String(describing: Row.self),
                                  String(describing: row))
            fatalError(rowError)
        }
        super.configure(with: row)
        leadingConstraint?.isActive = row.icon != nil
        titleLabel?.isHidden = row.title == nil
        textField?.placeholder = row.placeholder
        textField?.returnKeyType = row.returnType
        textField?.isSecureTextEntry = row.isSecret
        textField?.keyboardType = row.keyboardType
        reset()

        self.row?.reloadAction = { [weak self] in
            guard let self = self,
                let row = self.row else {
                return
            }
            self.isHidden = row.isHidden
            self.textField?.text = row.value
            self.textField?.isEnabled = row.isEnabled
        }
        self.row?.reloadAction?()
        _ = row.isValid(value: textField?.text, shouldUpdateView: false)
    }

    public func textFieldDidEndEditing(_: UITextField) {
        hintLabel?.text = row?.isValid(value: textField?.text, shouldUpdateView: false)
        let color = row?.isValid == true
        ? theme?.normalColor ?? Self.defaultNormalColor
        : theme?.errorColor ?? Self.defaultErrorColor
        titleLabel?.textColor = color
        lineView?.backgroundColor = color
        hintLabel?.textColor = color
        row?.didEndEditingAction?()
    }

    public func textFieldShouldReturn(_: UITextField) -> Bool {
        textField?.resignFirstResponder()
        row?.didReturnAction?()
        return true
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString: String) -> Bool {
        let currentValue = textField.text ?? .empty
        guard let range = Range(range, in: currentValue),
            let row = row else {
            return false
        }
        var newValue = currentValue.replacingCharacters(in: range, with: replacementString)
        let formattedValue = row.format(value: newValue)
        let isFormatted = formattedValue != newValue
        if isFormatted {
            textField.text = formattedValue
            newValue = formattedValue
        }
        row.isValid(value: newValue, shouldUpdateView: false)
        return !isFormatted
    }

    public func textFieldDidBeginEditing(_: UITextField) {
        let highlightedColor = theme?.highlightedColor ?? Self.defaultHighlightedColor
        titleLabel?.textColor = highlightedColor
        lineView?.backgroundColor = highlightedColor
        hintLabel?.textColor = theme?.normalColor ?? Self.defaultNormalColor
        hintLabel?.text = .space
        row?.didStartEditingAction?()
    }

    /// Constants
    private static var defaultHighlightedColor: UIColor { .black }
    private static var defaultNormalColor: UIColor { .gray }
    private static var defaultErrorColor: UIColor { .red }
}

import UIKit
