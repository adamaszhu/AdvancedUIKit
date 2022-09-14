/// LuhnRule presents the luhn requirement that a credit card number should follow.
///
/// - version: 1.9.6
/// - date: 14/09/22
/// - author: Adamas
public class LuhnRule: RuleType {

    /// The error message to return if the validation fails.
    private let message: String

    /// Initialize the rule
    /// - Parameter message: The error message to apply. 
    public init(message: String) {
        self.message = message
    }

    /// Run a check against a given credit card number to ensure it passes the Luhn's check.
    /// The code was adapted from a [gist](https://gist.github.com/cwagdev/635ce973e8e86da0403a)
    /// And the logic of the gist was checked against the [wikipedia page](https://en.wikipedia.org/wiki/Luhn_algorithm).
    /// The logic in a short form is:
    ///   1. Reverse the order of the digits in the number.
    ///   2. Take the first, third, ... and every other odd digit in the reversed digits and sum them to form the partial sum s1
    ///   3. Taking the second, fourth ... and every other even digit in the reversed digits:
    ///     a.Multiply each digit by two and sum the digits if the answer is greater than nine to form partial sums for the even digits
    ///     b. Sum the partial sums of the even digits to form s2
    ///
    public func isValid(value: String?) -> String? {

        let value = value ?? String()
        var sum = 0

        // Reverse the characters
        let reversedCharacters = value.reversed().map(String.init)

        for (index, element) in reversedCharacters.enumerated() {

            // Ensure the character is a digit
            guard let digit = Int(element) else { return message }

            // double the value of every second digit;
            // if the product of this doubling operation is greater than 9 (e.g., 8 × 2 = 16),
            // then sum the digits of the products (e.g., 16: 1 + 6 = 7, 18: 1 + 8 = 9).
            switch ((index % 2 == 1), digit) {
            case (true, 9):
                sum += 9
            case (true, 0 ... 8):
                sum += (digit * 2) % 9
            default:
                sum += digit
            }
        }

        // If the sum ends with a 0, it passes the Luhn's check
        return sum % 10 == 0 ? nil : message
    }
}
