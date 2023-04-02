/// CreditCardType presents the type of a credit card.
///
/// - version: 1.9.9
/// - date: 19/09/22
/// - author: Adamas
public enum CreditCardType: String {

    case master, visa, amex, other

    // The regex of each type
    private var regex: String {
        switch self {
            case .master:
                return Self.masterRegex
            case .visa:
                return Self.visaRegex
            case .amex:
                return Self.amexRegex
            case .other:
                return .empty
        }
    }

    /// Get the type of a credit card
    /// 
    /// - Parameter cardNumber: The number of the card
    public init(cardNumber: String) {
        let types: [CreditCardType] = [.visa, .master, .amex]
        self = types.first {
            cardNumber.range(of: $0.regex, options: .regularExpression) != nil
        } ?? .other
    }
}

/// Constants
private extension CreditCardType {
    static let amexRegex = "^3[47][0-9]{5,}$"
    static let masterRegex = "^(5|2)[1-5][0-9]{5,}$"
    static let visaRegex = "^4[0-9]{6,}$"
}
