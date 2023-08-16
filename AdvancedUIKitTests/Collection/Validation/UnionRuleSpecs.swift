final class UnionRuleSpecs: QuickSpec {

    override func spec() {
        describe("calls isValid(value)") {
            context("with two rules") {
                let unionRule = UnionRule(
                    rules: [MinLengthRule(minLength: 10,
                                          message: Self.error),
                            CurrencyRule(languages: [.english],
                                         message: Self.error)],
                    message: Self.error)
                context("with a string matching both rules") {
                    let string = "$1000000000"
                    it("returns nil") {
                        expect(unionRule.isValid(value: string)) == nil
                    }
                }
                context("with a string matching the first rule") {
                    let string = "A0000000000"
                    it("returns nil") {
                        expect(unionRule.isValid(value: string)) == nil
                    }
                }
                context("with a string matching the second rule") {
                    let string = "$1"
                    it("returns nil") {
                        expect(unionRule.isValid(value: string)) == nil
                    }
                }
                context("with a string matching neither rule") {
                    let string = "1"
                    it("returns the error message") {
                        expect(unionRule.isValid(value: string)) == Self.error
                    }
                }
            }
        }
    }
}

private extension UnionRuleSpecs {
    static let error = "Error"
}

import Nimble
import Quick
import AdvancedFoundation
@testable import AdvancedUIKit
