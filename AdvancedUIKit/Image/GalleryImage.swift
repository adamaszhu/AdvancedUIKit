/// GalleryImage view present an image in a GalleryView.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 15/06/2017
final class GalleryImage: UIScrollView {
    
    /// The zoom in increment for double tapping.
    private static let zoomInIncrement = CGFloat(2)
    
    /// The actual image view.
    @objc var imageView: UIImageView
    
    /// The image.
    @objc var image: UIImage? {
        set {
            imageView.image = newValue
        }
        get {
            return imageView.image
        }
    }
    
    /// The maximum zoom level.
    @objc var maxZoomLevel: CGFloat {
        set {
            maximumZoomScale = newValue
        }
        get {
            return maximumZoomScale
        }
    }
    
    /// The content mode of the image.
    @objc var imageMode: UIViewContentMode {
        set {
            imageView.contentMode = newValue
        }
        get {
            return imageView.contentMode
        }
    }
    
    /// The size of the GalleryImage.
    @objc var size: CGSize {
        set {
            contentSize = newValue
            frame.size = newValue
            imageView.frame.size = newValue
        }
        get {
            return frame.size
        }
    }
    
    /// The double tap gesture used to zoom in the image.
    @objc private (set) var doubleTapGestureRecognizer: UITapGestureRecognizer!
    
    /// Reset the zoom level of the image.
    @objc func resetZoomLevel() {
        setZoomScale(1, animated: true)
    }
    
    /// Perform a zoom in.
    @objc func zoomIn() {
        var zoomLevel = zoomScale + GalleryImage.zoomInIncrement
        zoomLevel = min(zoomLevel, maxZoomLevel)
        setZoomScale(zoomLevel, animated: true)
    }
    
    /// Initialize the image.
    init() {
        imageView = UIImageView()
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        backgroundColor = .clear
        delegate = self
        imageView.clipsToBounds = true
        doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(zoomIn))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTapGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        Logger.standard.logError(GalleryImage.initError)
        return nil
    }
    
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

import AdvancedFoundation
import UIKit
