final class CurrencyNumberRuleSpecs: QuickSpec {

    override func spec() {
        describe("calls isValid(value)") {
            let rule = CurrencyNumberRule(message: Self.error)
            context("with a currency string") {
                it("returns an error message") {
                    expect(rule.isValid(value: "$1")) == "Error"
                }
            }
            context("with an integer string") {
                it("returns an error message") {
                    expect(rule.isValid(value: "1")) == "Error"
                }
            }
            context("with a long decimal string") {
                it("returns an error message") {
                    expect(rule.isValid(value: "1.555")) == "Error"
                }
            }
            context("with a short currency string") {
                it("returns nil") {
                    expect(rule.isValid(value: "1.00")) == nil
                }
            }
            context("with a long currency string") {
                it("returns nil") {
                    expect(rule.isValid(value: "1,000.00")) == nil
                }
            }
        }
    }
}

private extension CurrencyNumberRuleSpecs {
    static let error = "Error"
}

import Nimble
import Quick
import AdvancedFoundation
@testable import AdvancedUIKit
