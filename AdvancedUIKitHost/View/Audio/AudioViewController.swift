final class AudioViewController: UIViewController {
    
    private static let ring = (name: "Ring.aiff", times: 3)
    
    private let ringHelper = RingHelper.shared
    
    @IBAction func ringWithCustomizedSoundAndVibration(_ sender: Any) {
        ringHelper.ring(withSound: AudioViewController.ring.name, forTimes: AudioViewController.ring.times)
    }
    
    @IBAction func ringWithCustomizedSound(_ sender: Any) {
        ringHelper.ring(withSound: AudioViewController.ring.name, forTimes: AudioViewController.ring.times, withVibration: false)
    }
    
    @IBAction func ringWithSystemSound(_ sender: Any) {
        ringHelper.ring(forTimes: AudioViewController.ring.times)
    }
    
}

import AdvancedUIKit
import UIKit
