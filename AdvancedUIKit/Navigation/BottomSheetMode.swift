/// BottomSheetMode defines how the bottom screen should be presented.
///
/// - author: Adamas
/// - version: 1.8.0
/// - date: 02/05/2022
public enum BottomSheetMode {
    // Fix the ratio
    case ratio(Double)

    // Adjust the height according to its content
    case auto

    // Fix the height to a pertentage of the screen
    case percentage(_ percentage: Double = Self.defaultModalHeightPercentage)
}

public extension BottomSheetMode {
    static let defaultModalHeightPercentage: CGFloat = 0.85
}

import UIKit
