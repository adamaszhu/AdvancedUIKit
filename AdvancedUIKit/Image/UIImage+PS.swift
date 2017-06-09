//import UIKit
//
///**
// * Add PS function to an UIImage.
// * - author: Adamas
// * - version: 0.0.5
// * - date: 27/10/2016
// */
//public extension UIImage {
//    
//    /**
//     * System error.
//     */
//    private static let FilterError = "The filter cannot be intialized."
//    private static let InputImageError = "The image is invalid."
//    private static let OutputImageError = "The image cannot be changed."
//    
//    /**
//     * Add blur effect to an image.
//     * - version: 0.0.4
//     * - date: 22/10/2016
//     * - parameter radius: The radius of the blur.
//     * - returns: The image with blur effect.
//     */
//    public func addGaussianBlur(withRadius radius: Int) -> UIImage {
//        let gaussianBlurFilter = CIFilter(name: "CIGaussianBlur")
//        if gaussianBlurFilter == nil {
//            logError(UIImage.FilterError)
//            return self
//        }
//        gaussianBlurFilter!.setDefaults()
//        let inputImage = UIKit.CIImage(image: self)
//        if inputImage == nil {
//            logError(UIImage.InputImageError)
//            return self
//        }
//        gaussianBlurFilter!.setValue(inputImage, forKey: kCIInputImageKey)
//        gaussianBlurFilter!.setValue(radius, forKey: kCIInputRadiusKey)
//        let outputImage = gaussianBlurFilter!.outputImage
//        if outputImage == nil {
//            logError(UIImage.OutputImageError)
//            return self
//        }
//        let context = CIContext(options: nil)
//        let cgiImage = context.createCGImage(outputImage!, fromRect: inputImage!.extent)
//        if cgiImage == nil {
//            logError(UIImage.OutputImageError)
//            return self
//        }
//        return UIImage(CGImage: cgiImage!)
//    }
//    
//    /**
//     * Add the opacity to the image.
//     * - version: 0.0.5
//     * - date: 27/10/2016
//     * - parameter opacity: The opacity.
//     * - returns: The image with opacity.
//     */
//    public func setOpacity(opacity: Double) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(size, false, scale)
//        drawAtPoint(CGPointZero, blendMode: CGBlendMode.Normal, alpha: CGFloat(opacity))
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        if image == nil {
//            logError(UIImage.InputImageError)
//            return self
//        }
//        UIGraphicsEndImageContext()
//        return image!
//    }
//    
//    /**
//     * Crop an image into a square one.
//     * - version: 0.0.4
//     * - date: 22/10/2016
//     * - returns: The cropped image.
//     */
//    public func cropSquare() -> UIImage {
//        let width = self.size.width
//        let height = self.size.height
//        var rect: CGRect
//        if width > height {
//            rect = CGRect(x: (width - height) / 2, y: 0, width: height, height: height)
//        } else {
//            rect = CGRect(x: 0, y: (height - width) / 2, width: width, height: width)
//        }
//        let imageRef = CGImageCreateWithImageInRect(self.CGImage!, rect);
//        if imageRef == nil {
//            logError(UIImage.InputImageError)
//            return self
//        }
//        let squareImage = UIImage(CGImage: imageRef!, scale: self.scale, orientation: self.imageOrientation)
//        return squareImage
//    }
//    
//    /**
//     * Compress an image with a maximum size provided.
//     * - version: 0.0.4
//     * - date: 22/10/2016
//     * - parameter maxSize: The max size of the new image.
//     * - returns: The compressed image.
//     */
//    public func compress(withMaxSize maxSize: Int) -> UIImage {
//        var imageData = UIImageJPEGRepresentation(self, 1)
//        if imageData == nil {
//            logError(UIImage.InputImageError)
//            return self
//        }
//        if imageData!.length <= maxSize {
//            return self
//        }
//        imageData = UIImageJPEGRepresentation(self, CGFloat(maxSize) / CGFloat(imageData!.length))
//        let image = UIImage(data: imageData!)
//        if image == nil {
//            logError(UIImage.OutputImageError)
//            return self
//        }
//        return image!
//    }
//    
//    /**
//     * Resize the image
//     * - version: 0.0.5
//     * - date: 27/10/2016
//     * - parameter width: The new width.
//     * - parameter height: The new height.
//     */
//    public func resize(toWidth width: Double, toHeight height: Double) -> UIImage {
//        let size = CGSize(width: width, height: height)
//        UIGraphicsBeginImageContextWithOptions(size, false, 0)
//        let bound = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
//        drawInRect(bound)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        if image == nil {
//            logError(UIImage.OutputImageError)
//            return self
//        }
//        return image!
//    }
//    
//}
