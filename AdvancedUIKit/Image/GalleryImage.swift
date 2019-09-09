/// GalleryImage view present an image in a GalleryView.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 16/08/2019
final class GalleryImage: UIScrollView {
    
    /// The actual image view.
    var imageView: UIImageView
    
    /// The image.
    var image: UIImage? {
        set {
            imageView.image = newValue
        }
        get {
            return imageView.image
        }
    }
    
    /// The maximum zoom level.
    var maxZoomLevel: CGFloat {
        set {
            maximumZoomScale = newValue
        }
        get {
            return maximumZoomScale
        }
    }
    
    /// The content mode of the image.
    var imageMode: UIViewContentMode {
        set {
            imageView.contentMode = newValue
        }
        get {
            return imageView.contentMode
        }
    }
    
    /// The size of the GalleryImage.
    var size: CGSize {
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
    private (set) var doubleTapGestureRecognizer: UITapGestureRecognizer!
    
    /// Reset the zoom level of the image.
    func resetZoomLevel() {
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
        super.init(frame: .zero)
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

/// UIScrollViewDelegate
extension GalleryImage: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard contentSize.width >= frame.width, contentSize.height >= frame.height else {
            setZoomScale(1, animated: false)
            return
        }
        var adjustOffset = contentOffset
        adjustOffset.x = max(adjustOffset.x, 0)
        adjustOffset.y = max(adjustOffset.y, 0)
        adjustOffset.x = min(adjustOffset.x, contentSize.width - frame.width)
        adjustOffset.y = min(adjustOffset.y, contentSize.height - frame.height)
        guard adjustOffset != contentOffset else {
            return
        }
        setContentOffset(adjustOffset, animated: false)
    }
}

/// Constants
private extension GalleryImage {
    
    /// Error message.
    static let initError = "Constructor init(coder) shouldn't be called."
    
    /// The zoom in increment for double tapping.
    static let zoomInIncrement: CGFloat = 2
}

import AdvancedFoundation
import UIKit
