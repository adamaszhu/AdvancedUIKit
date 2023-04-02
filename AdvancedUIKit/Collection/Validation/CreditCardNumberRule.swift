/// CreditCardNumberRule presents number requirement of a credit card number.
///
/// - version: 1.9.9
/// - date: 14d/11/22
/// - author: Adamas
public class CreditCardNumberRule: RuleType {

   /// The error message to return if the validation fails.
   let message: String

   /// Initialize the rule
   /// - Parameter message: The error message to apply.
   public init(message: String) {
       self.message = message
   }

   public func isValid(value: String?) -> String? {
       let value = value ?? String()
       return CreditCardType(cardNumber: value) == .other
       ? message
       : nil
   }
}
