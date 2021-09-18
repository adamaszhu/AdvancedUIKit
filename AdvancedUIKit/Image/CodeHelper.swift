#if !os(macOS)
/// Generate code images
///
/// - author: Adamas
/// - date: 15/09/2019
/// - version: 1.5.0
public final class CodeHelper {
    
    /// Create a code image.
    ///
    /// - Important:
    /// On iOS 14, the generated image cannot be applied to an `UIImageView` within a `UIScrollView`, whose `contentMode` is `.scaleAspectFit` or `.scaleAspectFill`.
    ///
    /// - Parameters:
    ///   - code: The code.
    ///   - type: The code type.
    ///   - size: The code size.
    public func createCode(_ code: String, as type: CodeType, with size: CGSize) -> UIImage? {
        guard let data = code.data(using: .ascii) else {
            Logger.standard.logError(Self.codingError)
            return nil
        }
        guard let filter = CIFilter(name: type.rawValue) else {
            Logger.standard.logError(Self.filterError)
            return nil
        }
        filter.setValue(data, forKey: Self.messageKey)
        guard let ciImage = filter.outputImage else {
            Logger.standard.logError(Self.outputError)
            return nil
        }
        let ciImageSize = ciImage.extent.size
        let transform = CGAffineTransform(scaleX: size.width / ciImageSize.width, y: size.height / ciImageSize.height)
        let transformedCIImage = ciImage.transformed(by: transform)
        return UIImage(ciImage: transformedCIImage)
    }
    
    /// The initializor
    public init() {}
}

/// Constants
private extension CodeHelper {
    
    /// Keys
    private static let messageKey = "inputMessage"
    
    /// System errors
    private static let codingError = "The code is not using ASCII standard."
    private static let filterError = "Cannot create a filter with MACOS."
    private static let outputError = "Cannot create the output image."
}

import AdvancedFoundation
import UIKit
#endif
