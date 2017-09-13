/// RingHelper provides support for playing rings and vibrations periodically.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 01/06/2017
final public class RingHelper {
    
    /// The singleton instance.
    public static let shared = RingHelper()
    
    /// The period between two rings or vibrates.
    private var period: Double
    
    /// The amount of time that the device still need to vibrate or ring.
    private var remainerCounter: Int
    
    /// Whether the vibration should be played or not.
    private var shouldVibrate: Bool
    
    /// The sound of the ring.
    private var soundID: SystemSoundID
    
    /// The bundle that the ring file existing in.
    private let bundle: Bundle
    
    /// Play a customized.
    ///
    /// - Parameters:
    ///   - soundFileName: The file name of the sound.
    ///   - times: How many times the device need to ring.
    ///   - shouldVibrate: Whether the vibration should be performed or not.
    ///   - period: The period between two vibrations or rings.
    /// - Returns: Whether the ring will be performed or not. False if a ring is being played or the sound file doesn't exist.
    public func ring(withSound soundFileName: String, forTimes times: Int = 1, withVibration shouldVibrate: Bool = true, withPeriod period: Double = defaultRingPeriod) -> Bool {
        guard remainerCounter == 0 else {
            Logger.standard.log(warning: RingHelper.playStatusWarning)
            return false
        }
        remainerCounter = times
        self.shouldVibrate = shouldVibrate
        self.period = period
        let fileInfoAccessor = FileInfoAccessor(path: soundFileName)
        guard let path = bundle.path(forResource: fileInfoAccessor.filename, ofType: fileInfoAccessor.fileExtension) else {
            Logger.standard.log(error: RingHelper.soundNameError, withDetail: soundFileName)
            return false
        }
        let url = URL(fileURLWithPath: path)
        // Register the customized sound.
        var newSoundID = SystemSoundID(0)
        AudioServicesCreateSystemSoundID(url as CFURL, &newSoundID)
        guard newSoundID != 0 else {
            Logger.standard.log(error: RingHelper.soundNameError, withDetail: soundFileName)
            return false
        }
        soundID = newSoundID
        performRing()
        return true
    }
    
    /// Play a system sound. Vibration is decided based on system setting.
    ///
    /// - Parameters:
    ///   - soundID: The ID of the system sound.
    ///   - times: How many times the device need to ring.
    ///   - period: The period between two vibrations or rings.
    /// - Returns: Whether the ring will be performed or not. False if a ring is being played.
    public func ring(withSoundID soundID: SystemSoundID = defaultSoundID, forTimes times: Int = 1, withPeriod period: Double = defaultRingPeriod) -> Bool {
        guard remainerCounter == 0 else {
            return false
        }
        self.soundID = soundID
        remainerCounter = times
        shouldVibrate = false
        self.period = period
        performRing()
        return true
    }
    
    /// Perform the actual ring and vibration.
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
    
    /// Initialize the object
    ///
    /// - Parameter bundle: The bundle where the ring file existing in.
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
