final class CurrencyRuleSpecs: QuickSpec {

    override func spec() {
        describe("calls isValid(value)") {
            let rule = CurrencyRule(languages: Language.allCases, message: Self.error)
            context("with a currency string in english") {
                it("returns nil") {
                    expect(rule.isValid(value: "$1")) == nil
                }
            }
            context("with a currency string in mandarin") {
                it("returns nil") {
                    expect(rule.isValid(value: "¥1")) == nil
                }
            }
            context("with a currency string in french") {
                it("returns an error message") {
                    expect(rule.isValid(value: "€1")) == "Error"
                }
            }
            context("with a random string") {
                it("returns an error message") {
                    expect(rule.isValid(value: "Test")) == "Error"
                }
            }
        }
    }
}

private extension CurrencyRuleSpecs {
    static let error = "Error"
}

import Nimble
import Quick
import AdvancedFoundation
@testable import AdvancedUIKit
