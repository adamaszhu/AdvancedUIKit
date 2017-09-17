final class AudioViewController: UIViewController {
    
    private let ring = (name: "Ring.aiff", times: 3)
    
    private let ringHelper = RingHelper.shared
    
    @IBAction func ringWithCustomizedSoundAndVibration(_ sender: Any) {
        ringHelper.ring(withSound: ring.name, forTimes: ring.times)
    }
    
    @IBAction func ringWithCustomizedSound(_ sender: Any) {
        ringHelper.ring(withSound: ring.name, forTimes: ring.times, withVibration: false)
    }
    
    @IBAction func ringWithSystemSound(_ sender: Any) {
        ringHelper.ring(forTimes: ring.times)
    }
    
}

import AdvancedUIKit
import UIKit
