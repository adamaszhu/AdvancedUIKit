/// Image+PS adds PS function to an UIImage.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 16/08/2019
public extension UIImage {
    
    /// Add blur effect to an image.
    ///
    /// - Parameter radius: The radius of the blur.
    /// - Returns: The image with blur effect.
    func addingGaussianBlur(withRadius radius: Int) -> UIImage {
        guard let gaussianBlurFilter = CIFilter(name: UIImage.gaussianBlurFilterName) else {
            Logger.standard.logError(UIImage.filterError)
            return self
        }
        gaussianBlurFilter.setDefaults()
        guard let inputImage = CIImage(image: self) else {
            Logger.standard.logError(UIImage.inputImageError)
            return self
        }
        gaussianBlurFilter.setValue(inputImage, forKey: kCIInputImageKey)
        gaussianBlurFilter.setValue(radius, forKey: kCIInputRadiusKey)
        guard let outputImage = gaussianBlurFilter.outputImage else {
            Logger.standard.logError(UIImage.outputImageError)
            return self
        }
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(outputImage, from: inputImage.extent) else {
            Logger.standard.logError(UIImage.outputImageError)
            return self
        }
        return UIImage(cgImage: cgImage)
    }
    
    /// Add the opacity to the image.
    ///
    /// - Parameter opacity: The opacity.
    /// - Returns: The image with opacity.
    func addingOpacity(_ opacity: Double) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: CGFloat(opacity))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            Logger.standard.logError(UIImage.outputImageError)
            UIGraphicsEndImageContext()
            return self
        }
        UIGraphicsEndImageContext()
        return image
    }

    /// Crop an image into a square one.
    ///
    /// - Returns: The cropped image.
    func croppingSquare() -> UIImage {
        let width = size.width
        let height = size.height
        var rect: CGRect
        if width > height {
            rect = CGRect(x: (width - height) / 2, y: 0, width: height, height: height)
        } else {
            rect = CGRect(x: 0, y: (height - width) / 2, width: width, height: width)
        }
        guard let inputImage = cgImage else {
            Logger.standard.logError(UIImage.inputImageError)
            return self
        }
        guard let outputImage = inputImage.cropping(to: rect) else {
            Logger.standard.logError(UIImage.outputImageError)
            return self
        }
        return UIImage(cgImage: outputImage)
    }

    /// Compress an image with a maximum size provided.
    ///
    /// - Parameter maxSize: The max size of the new image.
    /// - Returns: The compressed image.
    func compressing(withMaxSize maxSize: Int) -> UIImage {
        guard let imageData = jpegData(compressionQuality: 1) else {
            Logger.standard.logError(UIImage.inputImageError)
            return self
        }
        guard imageData.count > maxSize else {
            return self
        }
        guard let comressedData = jpegData(compressionQuality: CGFloat(maxSize) / CGFloat(imageData.count)) else {
            Logger.standard.logError(UIImage.outputImageError)
            return self
        }
        guard let image = UIImage(data: comressedData) else {
            Logger.standard.logError(UIImage.outputImageError)
            return self
        }
        return image
    }

    /// Resize the image
    ///
    /// - Parameters:
    ///   - width: The new width.
    ///   - height: The new height.
    func resizing(toWidth width: CGFloat, andHeight height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        return resizing(to: size)
    }
    
    /// Resize the image
    ///
    /// - Parameter size: The new size.
    func resizing(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let bound = CGRect(origin: .zero, size: size)
        draw(in: bound)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            Logger.standard.logError(UIImage.outputImageError)
            UIGraphicsEndImageContext()
            return self
        }
        UIGraphicsEndImageContext()
        return image
    }
}

/// Constants
private extension UIImage {
    
    /// System error.
    static let filterError = "The filter cannot be intialized."
    static let inputImageError = "The image is invalid."
    static let outputImageError = "The image cannot be changed."
    
    /// The filter names.
    static let gaussianBlurFilterName = "CIGaussianBlur"
}

import AdvancedFoundation
import UIKit
