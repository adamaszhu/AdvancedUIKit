class AudioViewController: UIViewController {
    
    private let ringName = "Ring.aiff"
    private let ringTimes = 3
    
    private let ringHelper: RingHelper
    
    required init?(coder aDecoder: NSCoder) {
        ringHelper = RingHelper.shared
        super.init(coder: aDecoder)
    }
    
    @IBAction func ringWithCustomizedSoundAndVibration(_ sender: Any) {
        ringHelper.ring(withSound: ringName, forTimes: ringTimes)
    }
    
    @IBAction func ringWithCustomizedSound(_ sender: Any) {
        ringHelper.ring(withSound: ringName, forTimes: ringTimes, withVibration: true)
    }
    
    @IBAction func ringWithSystemSoundAndVibration(_ sender: Any) {
        ringHelper.ring(forTimes: ringTimes)
    }
    
    @IBAction func ringWithSystemSound(_ sender: Any) {
        ringHelper.ring(forTimes: ringTimes, withVibration: true)
    }
    
}

import AdvancedUIKit
import UIKit
