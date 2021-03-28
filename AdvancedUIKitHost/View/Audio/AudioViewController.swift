final class AudioViewController: UIViewController {
    
    private let ringHelper: RingHelper = RingHelper()
    
    @IBAction func ringWithCustomizedSoundAndVibration(_ sender: Any) {
        ringHelper.ring(withSound: Self.ringName, forTimes: Self.ringTime)
    }
    
    @IBAction func ringWithCustomizedSound(_ sender: Any) {
        ringHelper.ring(withSound: Self.ringName, forTimes: Self.ringTime, withVibration: false)
    }
    
    @IBAction func ringWithSystemSound(_ sender: Any) {
        ringHelper.ring(forTimes: Self.ringTime)
    }
}

private extension AudioViewController {
    static let ringName = "Ring.aiff"
    static let ringTime = 3
}

import AdvancedUIKit
import UIKit
