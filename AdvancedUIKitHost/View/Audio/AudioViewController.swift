class AudioViewController: UIViewController {
    
    private let ringName = "Ring.aiff"
    private let ringTimes = 3
    
    private let ringHelper: RingHelper
    
    required init?(coder aDecoder: NSCoder) {
        ringHelper = RingHelper.shared
        super.init(coder: aDecoder)
    }
    
    @IBAction func ringWithCustomizedSoundAndVibration(_ sender: Any) {
        _ = ringHelper.ring(withSound: ringName, forTimes: ringTimes)
    }
    
    @IBAction func ringWithCustomizedSound(_ sender: Any) {
        _ = ringHelper.ring(withSound: ringName, forTimes: ringTimes, withVibration: false)
    }
    
    @IBAction func ringWithSystemSound(_ sender: Any) {
        _ = ringHelper.ring(forTimes: ringTimes)
    }
    
}

import AdvancedUIKit
import UIKit
