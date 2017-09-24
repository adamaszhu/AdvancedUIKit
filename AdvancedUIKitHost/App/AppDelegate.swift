@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let windowBackgroundColor = UIColor(red: 125/255, green: 182/255, blue: 216/255, alpha: 1)

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window?.backgroundColor = windowBackgroundColor
        return true
    }

}

import UIKit
