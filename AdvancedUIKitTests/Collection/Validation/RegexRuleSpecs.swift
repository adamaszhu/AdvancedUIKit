final class RegexRuleSpecs: QuickSpec {

    override func spec() {
        describe("calls isValid(value)") {
            context("created via init(regex:message)") {
                let rule = RegexRule(regex: Self.regex0, message: Self.error)
                context("with valid string") {
                    it("returns nil") {
                        expect(rule.isValid(value: "00000")) == nil
                    }
                }
                context("with invalid string") {
                    it("returns the error message") {
                        expect(rule.isValid(value: "00001")) == Self.error
                    }
                }
            }
            context("created via init(regexes:message)") {
                let rule = RegexRule(regexes: [Self.regex0, Self.regex1], message: Self.error)
                context("with valid string") {
                    it("returns nil") {
                        expect(rule.isValid(value: "00000")) == nil
                        expect(rule.isValid(value: "11111")) == nil
                    }
                }
                context("with invalid string") {
                    it("returns the error message") {
                        expect(rule.isValid(value: "00001")) == Self.error
                    }
                }
            }
        }
    }
}

private extension RegexRuleSpecs {
    static let regex0 = "^[0]+$"
    static let regex1 = "^[1]+$"
    static let error = "Error"
}

import Nimble
import Quick
@testable import AdvancedUIKit
