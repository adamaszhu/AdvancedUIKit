/// RingHelper+Constant defines all constants used by RingHelper.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 14/09/2017
extension RingHelper {
    
    /// The default period between two rings or vibrations.
    public static let defaultRingPeriod = 1.5
    
    /// The system sound.
    public static let defaultSoundID = SystemSoundID(1022)
    
    /// System error.
    static let soundNameError = "The sound file doesn't exist."
    
    /// System warning.
    static let playStatusWarning = "A sound is currently being played."
    
}

import AudioToolbox
