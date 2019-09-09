final class RemoteNotificationSpecs: QuickSpec {
    
    override func spec() {
        describe("calls init(userInfo)") {
            context("with alert message") {
                let userInfo: [AnyHashable : Any] = ["aps": ["alert": "title"]]
                let notification = RemoteNotification(userInfo: userInfo)
                it("generates the object") {
                    expect(notification).toNot(beNil())
                }
                it("gets values") {
                    expect(notification?.title) == "title"
                    expect(notification?.body).to(beNil())
                }
            }
            context("with alert dictionary") {
                let userInfo: [AnyHashable : Any] = ["aps": ["alert": ["title": "title", "body": "body"]]]
                let notification = RemoteNotification(userInfo: userInfo)
                it("generates the object") {
                    expect(notification).toNot(beNil())
                }
                it("gets values") {
                    expect(notification?.title) == "title"
                    expect(notification?.body) == "body"
                }
            }
            context("without the aps key") {
                let userInfo: [AnyHashable : Any] = [:]
                let notification = RemoteNotification(userInfo: userInfo)
                it("doesn't the object") {
                    expect(notification).to(beNil())
                }
            }
            context("without the alert key") {
                let userInfo: [AnyHashable : Any] = ["aps": [:]]
                let notification = RemoteNotification(userInfo: userInfo)
                it("doesn't the object") {
                    expect(notification).to(beNil())
                }
            }
        }
    }
}

import Nimble
import Quick
@testable import AdvancedUIKit
