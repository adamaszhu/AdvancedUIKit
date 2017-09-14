final class AudioViewController: UIViewController {
    
    private static let ringName = "Ring.aiff"
    private static let ringTimes = 3
    
    private let ringHelper = RingHelper.shared
    
    @IBAction func ringWithCustomizedSoundAndVibration(_ sender: Any) {
        ringHelper.ring(withSound: AudioViewController.ringName, forTimes: AudioViewController.ringTimes)
    }
    
    @IBAction func ringWithCustomizedSound(_ sender: Any) {
        ringHelper.ring(withSound: AudioViewController.ringName, forTimes: AudioViewController.ringTimes, withVibration: false)
    }
    
    @IBAction func ringWithSystemSound(_ sender: Any) {
        ringHelper.ring(forTimes: AudioViewController.ringTimes)
    }
    
}

import AdvancedUIKit
import UIKit
