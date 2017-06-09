//import UIKit
//
///**
// * GalleryImage view present an image in a GalleryView.
// * - author: Adamas
// * - date: 23/10/2016
// * - version: 0.0.2
// */
//class GalleryImage: UIScrollView {
//    
//    /**
//     * System error.
//     */
//    private static let ImageViewError = "The image has not been added to the image view yet."
//    
//    /**
//     * The actual image view.
//     */
//    var imageView: UIImageView? {
//        /**
//         * - date: 23/10/2016
//         * - version: 0.0.2
//         */
//        get {
//            if subviews.count == 0 {
//                logError(GalleryImage.ImageViewError)
//                return nil
//            }
//            return subviews[0] as? UIImageView
//        }
//    }
//    
//}
