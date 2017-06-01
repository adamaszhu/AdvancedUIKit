/**
 * RingHelper provides support for playing rings and vibrations periodically.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 01/06/2017
 */
public class RingHelper {
    
    /**
     * The default period between two rings or vibrations.
     */
    private let defaultRingPeriod = 1.5
    
    /**
     * The period between two rings or vibrates.
     */
    private var period: Double
    
    /**
     * The amount of time that the device still need to vibrate or ring.
     */
    private var remainerCounter: Int
    
    /**
     * Whether the vibration should be played or not.
     */
    private var shouldVibrate: Bool
    
    /**
     * The sound of the ring.
     */
    private var soundID: SystemSoundID
    
    /**
     * Initialize the object
     */
    public init() {
        remainerCounter = 0
        soundID = 0
        shouldVibrate = true
        period = defaultRingPeriod
    }
    
}

import AudioToolbox
import Foundation








///**
// * Play a sound.
// * - version: 0.0.2
// * - date: 04/10/2016
// * - parameter soundName: The file name of the sound.
// * - parameter times: How many times the device need to ring.
// * - parameter shouldVibrate: Whether the vibration should be performed or not.
// * - parameter period: The period between two vibrations or rings.
// */
//open func ring(withSound soundName: String? = nil, forTimes times: Int = 1, withVibration shouldVibrate: Bool = true, withPeriod period: Double = DefaultPeriod) {
//    counter = times
//    self.shouldVibrate = shouldVibrate
//    self.period = period
//    var soundURL: URL?
//    if soundName != nil {
//        let resourceAccessor = ResourceAccessor.defaultAccessor
//        soundURL = resourceAccessor.getURL(ofResource: soundName!)
//    }
//    if soundURL != nil {
//        // COMMENT: Set the customized sound.
//        AudioServicesCreateSystemSoundID(soundURL!, &soundID)
//    }
//    performRing()
//}
//
///**
// * Perform the actual ring and vibration.
// * - version: 0.0.2
// * - date: 04/10/2016
// */
//func performRing() {
//    AudioServicesPlaySystemSound(soundID)
//    if shouldVibrate {
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
//    }
//    counter -= 1
//    if counter > 0 {
//        perform(#selector(performRing), with: nil, afterDelay: period)
//    }
//}
//    
