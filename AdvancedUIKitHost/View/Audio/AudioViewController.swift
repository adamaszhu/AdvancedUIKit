final class AudioViewController: UIViewController {
    
    private let ringHelper: RingHelper = RingHelper()
    
    @IBAction func ringWithCustomizedSoundAndVibration(_ sender: Any) {
        ringHelper.ring(withSound: AudioViewController.ringName, forTimes: AudioViewController.ringTime)
    }
    
    @IBAction func ringWithCustomizedSound(_ sender: Any) {
        ringHelper.ring(withSound: AudioViewController.ringName, forTimes: AudioViewController.ringTime, withVibration: false)
    }
    
    @IBAction func ringWithSystemSound(_ sender: Any) {
        ringHelper.ring(forTimes: AudioViewController.ringTime)
    }
}

private extension AudioViewController {
    static let ringName = "Ring.aiff"
    static let ringTime = 3
}

import AdvancedUIKit
import UIKit
