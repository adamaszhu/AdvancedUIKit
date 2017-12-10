/// ExpandableMapView is used to add full screen function to the map view.
///
/// - author: Adamas
/// - version: 1.0.3
/// - date: 09/06/2017
final public class ExpandableMapView: MapView {
    
    /// The gesture filter to expand the view.
    @objc let gestureFilterView: UIView
    
    /// The button used to collapse the view.
    @objc let collapseButton: UIButton
    
    /// The blur effect background of the collapse button.
    @objc let collapseButtonBackgroundView: UIVisualEffectView
    
    /// The icon on the collapse button.
    @objc public var collapseIcon: UIImage? {
        set {
            guard let newImage = newValue else {
                return
            }
            collapseButton.setImage(newImage, for: .normal)
            collapseButton.setImage(newImage, for: .highlighted)
            collapseButton.frame.size = newImage.size
            collapseButtonBackgroundView.frame.size = newImage.size
        }
        get {
            return collapseButton.imageView?.image
        }
    }
    
    /// The origin of the collapse button.
    @objc public var collapseIconFrame: CGRect {
        set {
            collapseButton.frame = newValue
            collapseButtonBackgroundView.frame = newValue
        }
        get {
            return collapseButton.frame
        }
    }
    
    /// The radius of the background view.
    @objc public var collapseButtonBackgroundRadius: Int {
        set {
            collapseButtonBackgroundView.layer.cornerRadius = CGFloat(newValue)
            collapseButtonBackgroundView.clipsToBounds = true
        }
        get {
            return Int(collapseButtonBackgroundView.layer.cornerRadius)
        }
    }
    
    /// The background margin.
    @objc public var collapseButtonBackgroundMargin: Int {
        set {
            let margin = CGFloat(newValue)
            collapseButtonBackgroundView.frame.origin = .init(x: collapseButton.frame.origin.x - margin, y: collapseButton.frame.origin.y - margin)
            collapseButtonBackgroundView.frame.size = .init(width: collapseButton.frame.width + 2 * margin, height: collapseButton.frame.height + 2 * margin)
        }
        get {
            let margin = collapseButtonBackgroundView.frame.origin.x - collapseButton.frame.origin.x
            return abs(Int(margin))
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        gestureFilterView = UIView()
        collapseButton = UIButton()
        collapseButtonBackgroundView = UIVisualEffectView()
        super.init(coder: aDecoder)
        collapseButton.isHidden = true
        collapseButton.addTarget(self, action: #selector(collapse), for: .touchUpInside)
        collapseButtonBackgroundView.effect = UIBlurEffect()
        collapseButtonBackgroundView.isHidden = true
        gestureFilterView.frame = bounds
        gestureFilterView.backgroundColor = UIColor.clear
        let expandGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(expand))
        gestureFilterView.addGestureRecognizer(expandGestureRecognizer)
    }
    
    @objc var originalSuperview: UIView!
    var originalZIndex: Int!
    var originalFrame: CGRect!
    @objc var originalFrameConstraints: [NSLayoutConstraint]!
    @objc var originalConstraints: [NSLayoutConstraint]!
    
    @objc public var isExpandable: Bool {
        set {
            if newValue {
                addSubview(gestureFilterView)
                addSubview(collapseButtonBackgroundView)
                addSubview(collapseButton)
            } else {
                gestureFilterView.removeFromSuperview()
                collapseButton.removeFromSuperview()
                collapseButtonBackgroundView.removeFromSuperview()
            }
        }
        get {
            return subviews.contains(gestureFilterView)
        }
    }
    
}

import MapKit
