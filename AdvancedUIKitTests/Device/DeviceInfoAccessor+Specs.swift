class DeviceInfoAccessorSpecs: QuickSpec {
    
    override func spec() {
        let deviceInfoAccessor = DeviceInfoAccessor()
        describe("has shared") {
            it("is not nil") {
                expect(DeviceInfoAccessor.shared).toNot(beNil())
            }
        }
        describe("has systemVersion") {
            it("is correct version") {
                expect(deviceInfoAccessor.systemVersion) == "10.3"
            }
        }
        describe("has majorSystemVersion") {
            it("is correct version") {
                expect(deviceInfoAccessor.majorSystemVersion) == 10
            }
        }
        describe("has deviceType") {
            it("is correct type") {
                expect(deviceInfoAccessor.deviceType) == DeviceType.phone
            }
        }
        describe("calls init(device:processInfo)") {
            let deviceInfoAccessor = DeviceInfoAccessor(device: UIDevice.current)
            context("with device") {
                it("returns object") {
                    expect(deviceInfoAccessor).toNot(beNil())
                }
            }
            context("with processInfo") {
                let deviceInfoAccessor = DeviceInfoAccessor(processInfo: ProcessInfo())
                it("returns object") {
                    expect(deviceInfoAccessor).toNot(beNil())
                }
            }
        }
    }
    
}

import Quick
import Nimble
import UIKit
@testable import AdvancedUIKit
