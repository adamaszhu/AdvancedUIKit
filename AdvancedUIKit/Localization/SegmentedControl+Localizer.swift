/**
 * SegmentedControl+Localizer provides localization support for a segmented control.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 02/06/2017
 */
public extension UISegmentedControl {
    
    /**
     * UIView
     */
    public override func localize(withLocalizationFile localizationFile: String) {
        for segmentIndex in 0 ..< numberOfSegments {
            if let segmentTitle = titleForSegment(at: segmentIndex) {
                setTitle(segmentTitle.localize(withLocalizationFile: localizationFile), forSegmentAt: segmentIndex)
            }
        }
    }
    
}

import UIKit
