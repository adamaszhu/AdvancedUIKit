/**
 * GalleryImage view present an image in a GalleryView.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 15/06/2017
 */
class GalleryImage: UIScrollView {
    
    /**
     * Error message.
     */
    private static let initError = "Constructor init(coder) shouldn't be called."
    
    /**
     * The actual image view.
     */
    private var imageView: UIImageView
    
    /**
     * The image.
     */
    var image: UIImage? {
        set {
            imageView.image = newValue
        }
        get {
            return imageView.image
        }
    }
    
    /**
     * The maximum zoom level.
     */
    var maxZoomLevel: CGFloat {
        set {
            maximumZoomScale = newValue
        }
        get {
            return maximumZoomScale
        }
    }
    
    /**
     * Initialize the image.
     */
    init() {
        imageView = UIImageView()
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        isScrollEnabled = false
        imageView.clipsToBounds = true
    }
    
    /**
     * UIView
     */
    required init?(coder aDecoder: NSCoder) {
        Logger.standard.logError(GalleryImage.initError)
        return nil
    }
    
    /**
     * UIView
     */
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        imageView.frame = bounds
        contentSize = bounds.size
        guard imageView.superview == nil else {
            return
        }
        addSubview(imageView)
    }
    
}

import UIKit
