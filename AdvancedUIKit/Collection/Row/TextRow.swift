/// TextRow presents a text item in the collection.
///
/// - version: 1.8.0
/// - date: 08/10/21
/// - author: Adamas
open class TextRow: LabelRow, TextRowType {

    public let placeholder: String?
    public let returnType: UIReturnKeyType
    public let isSecret: Bool
    public let keyboardType: UIKeyboardType
    public var didReturnAction: (() -> Void)?
    public var didChangeValidationAction: ((Bool) -> Void)?
    public var didChangeValueAction: ((String?) -> Void)?

    public var value: String? {
        didSet {
            if oldValue != value {
                didChangeValueAction?(value)
                reloadAction?()
            }
        }
    }

    public private(set) var isValid: Bool = false {
        didSet {
            if oldValue != isValid {
                didChangeValidationAction?(isValid)
            }
        }
    }

    /// Rules that the value should follow.
    private let rules: [RuleType]

    /// Initialize the row
    /// - Parameters:
    ///   - icon: The icon of the row.
    ///   - title: The title of the row.
    ///   - subtitle: The subtitle of the row.
    ///   - placeholder: The placeholder of the text field.
    ///   - isSecret: Whether or not the text field should be masked.
    ///   - returnType: The return type of the keyboard.
    ///   - keyboardType: The keyboard type.
    ///   - rules: The rule set that the text field should follow.
    public init(icon: UIImage? = nil,
         title: String? = nil,
         subtitle: String? = nil,
         placeholder: String? = nil,
         isSecret: Bool = false,
         returnType: UIReturnKeyType = .go,
         keyboardType: UIKeyboardType = .default,
         rules: [RuleType] = []) {
        self.rules = rules
        self.isSecret = isSecret
        self.returnType = returnType
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        super.init(icon: icon, title: title, subtitle: subtitle)
    }

    public func isValid(value: String?) -> String? {
        self.value = value
        for rule in rules {
            if let error = rule.isValid(value: value) {
                isValid = false
                return error
            }
        }
        isValid = true
        return .space
    }
}

/// The type of the row.
public protocol TextRowType: LabelRowType {

    /// The placeholder of the text field.
    var placeholder: String? { get }

    /// Whether or not the input value is valid according to roles.
    var isValid: Bool { get }

    /// The return type of the keyboard.
    var returnType: UIReturnKeyType { get }

    /// Whether or not the text should be masked.
    var isSecret: Bool { get }

    /// The keyboard type of the text field.
    var keyboardType: UIKeyboardType { get }

    /// The action to be performed when the return key is clicked.
    var didReturnAction: (() -> Void)? { get set }

    /// The value of the text field.
    var value: String? { get set }

    /// The callback for validation changing.
    var didChangeValidationAction: ((Bool) -> Void)? { get set }

    /// The callback for value changing.
    var didChangeValueAction: ((String?) -> Void)? { get set }

    /// Validate all rules.
    /// - Parameter value: The new value to be validated.
    /// - Returns: The first error message. Nil if the value is valid.
    func isValid(value: String?) -> String?
}

import UIKit
