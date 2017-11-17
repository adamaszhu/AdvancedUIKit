/// ExpandableMapView is used to add full screen function to the map view.
///
/// - author: Adamas
/// - version: 1.0.3
/// - date: 09/06/2017
final public class ExpandableMapView: MapView {
    
    /// The gesture filter to expand the view.
    let gestureFilterView: UIView
    
    /// The button used to collapse the view.
    let collapseButton: UIButton
    
    /// The blur effect background of the collapse button.
    let collapseButtonBackgroundView: UIVisualEffectView
    
    /// The icon on the collapse button.
    public var collapseIcon: UIImage? {
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
    public var collapseIconFrame: CGRect {
        set {
            collapseButton.frame = newValue
            collapseButtonBackgroundView.frame = newValue
        }
        get {
            return collapseButton.frame
        }
    }
    
    /// The radius of the background view.
    public var collapseButtonBackgroundRadius: Int {
        set {
            collapseButtonBackgroundView.layer.cornerRadius = CGFloat(newValue)
        }
        get {
            return Int(collapseButtonBackgroundView.layer.cornerRadius)
        }
    }
    
    /// The background margin.
    public var collapseButtonBackgroundMargin: Int {
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
    
    var originalSuperview: UIView!
    var originalZIndex: Int!
    var originalFrame: CGRect!
    var originalFrameConstraints: [NSLayoutConstraint]!
    var originalConstraints: [NSLayoutConstraint]!
    
    public var isExpandable: Bool {
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
