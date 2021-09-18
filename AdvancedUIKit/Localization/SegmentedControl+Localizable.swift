#if !os(macOS)
/// SegmentedControl+Localizable provides localization support for a segmented control.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 31/08/2019
public extension UISegmentedControl {
    
    override func localize(withLocalizationFile localizationFile: String = defaultLocalizationFile) {
        for segmentIndex in 0 ..< numberOfSegments {
            if let segmentTitle = titleForSegment(at: segmentIndex) {
                setTitle(segmentTitle.localizedString(withLocalizationFile: localizationFile), forSegmentAt: segmentIndex)
            }
        }
    }
}

import UIKit
#endif
