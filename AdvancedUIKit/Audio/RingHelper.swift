/**
 * RingHelper provides support for playing rings and vibrations periodically.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 01/06/2017
 */
public class RingHelper {
    
    /**
     * The singleton instance.
     */
    public static let shared: RingHelper = RingHelper()
    
    /**
     * The default period between two rings or vibrations.
     */
    private static let defaultRingPeriod = 1.5
    
    /**
     * The system sound.
     */
    private static let defaultSoundID = SystemSoundID(1104)
    
    /**
     * System error.
     */
    private let soundNameError = "The sound file doesn't exist."
    
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
     * The bundle that the ring file existing in.
     */
    private let bundle: Bundle
    
    /**
     * Play a customized.
     * - parameter soundFileName: The file name of the sound.
     * - parameter times: How many times the device need to ring.
     * - parameter shouldVibrate: Whether the vibration should be performed or not.
     * - parameter period: The period between two vibrations or rings.
     */
    public func ring(withSound soundFileName: String, forTimes times: Int = 1, withVibration shouldVibrate: Bool = true, withPeriod period: Double = defaultRingPeriod) {
        remainerCounter = times
        self.shouldVibrate = shouldVibrate
        self.period = period
        let fileInfoAccessor = FileInfoAccessor(path: soundFileName)
        guard let path = bundle.path(forResource: fileInfoAccessor.filename, ofType: fileInfoAccessor.fileExtension) else {
            Logger.standard.logError(soundNameError, withDetail: soundFileName)
            return
        }
        let url = URL(fileURLWithPath: path)
        // COMMENT: Register the customized sound.
        var newSoundID = SystemSoundID(0)
        AudioServicesCreateSystemSoundID(url as CFURL, &newSoundID)
        guard newSoundID != 0 else {
            Logger.standard.logError(soundNameError, withDetail: soundFileName)
            return
        }
        soundID = newSoundID
        performRing()
    }
    
    /**
     * Play a system sound.
     * - parameter soundID: The ID of the system sound.
     * - parameter times: How many times the device need to ring.
     * - parameter shouldVibrate: Whether the vibration should be performed or not.
     * - parameter period: The period between two vibrations or rings.
     */
    public func ring(withSoundID soundID: SystemSoundID = defaultSoundID, forTimes times: Int = 1, withVibration shouldVibrate: Bool = true, withPeriod period: Double = defaultRingPeriod) {
        self.soundID = soundID
        remainerCounter = times
        self.shouldVibrate = shouldVibrate
        self.period = period
        performRing()
    }
    
    /**
     * Perform the actual ring and vibration.
     */
    func performRing() {
        AudioServicesPlaySystemSound(soundID)
        if shouldVibrate {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
        remainerCounter = remainerCounter - 1
        if remainerCounter > 0 {
            let dispatchTime = DispatchTime.now() + period
            DispatchQueue.main.asyncAfter(deadline: dispatchTime) { [unowned self] _ in
                self.performRing()
            }
        }
    }
    
    /**
     * Initialize the object
     * - parameter bundle: The bundle where the ring file existing in.
     */
    private init(bundle: Bundle = Bundle.main) {
        remainerCounter = 0
        soundID = 0
        shouldVibrate = true
        period = 0
        self.bundle = bundle
    }
    
}

import AudioToolbox
import Foundation
