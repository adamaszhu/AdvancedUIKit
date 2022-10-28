#if !os(macOS)
class DeviceInfoAccessorSpecs: QuickSpec {
    
    override func spec() {
        let deviceInfoAccessor = DeviceInfoAccessor.shared
        describe("has shared") {
            it("is not nil") {
                expect(DeviceInfoAccessor.shared).toNot(beNil())
            }
        }
        describe("has systemVersion") {
            it("is correct version") {
                expect(deviceInfoAccessor.systemVersion) == "16.0"
            }
        }
        describe("has majorSystemVersion") {
            it("is correct version") {
                expect(deviceInfoAccessor.majorSystemVersion) == 16
            }
        }
        describe("has deviceType") {
            it("is correct type") {
                expect(deviceInfoAccessor.deviceType) == DeviceType.phone
            }
        }
    }
}

import Quick
import Nimble
@testable import AdvancedUIKit
#endif
