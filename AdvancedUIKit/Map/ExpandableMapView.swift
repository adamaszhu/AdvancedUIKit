/**
 * ExpandableMapView is used to add full screen function to the map view.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 09/06/2017
 */
public class ExpandableMapView: MapView {
    
    /**
     * The gesture filter to expand the view.
     */
    let gestureFilterView: UIView
    
    /**
     * The button used to collapse the view.
     */
    let collapseButton: UIButton
    
    /**
     * The icon on the collapse button.
     */
    public var collapseIcon: UIImage? {
        set {
            guard let newImage = newValue else {
                return
            }
            collapseButton.setImage(newImage, for: .normal)
            collapseButton.setImage(newImage, for: .highlighted)
            collapseButton.frame.size = newImage.size
        }
        get {
            return collapseButton.imageView?.image
        }
    }
    
    /**
     * The origin of the collapse button.
     */
    public var collapseIconOrigin: CGPoint {
        set {
            collapseButton.frame.origin = newValue
        }
        get {
            return collapseButton.frame.origin
        }
    }
    
    /**
     * UIView
     */
    public required init?(coder aDecoder: NSCoder) {
        gestureFilterView = UIView()
        collapseButton = UIButton()
        super.init(coder: aDecoder)
        collapseButton.isHidden = true
        collapseButton.addTarget(self, action: #selector(collapse), for: .touchUpInside)
        gestureFilterView.frame = bounds
        gestureFilterView.backgroundColor = UIColor.clear
        let expandGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(expand))
        gestureFilterView.addGestureRecognizer(expandGestureRecognizer)
    }
    
    /**
     * ExpandableView
     */
    var originalSuperview: UIView!
    
    /**
     * ExpandableView
     */
    var originalZIndex: Int!
    
    /**
     * ExpandableView
     */
    var originalFrame: CGRect!
    
    /**
     * ExpandableView
     */
    var originalFrameConstraints: Array<NSLayoutConstraint>!
    
    /**
     * ExpandableView
     */
    var originalConstraints: Array<NSLayoutConstraint>!
    
    /**
     * ExpandableView
     */
    public var isExpandable: Bool {
        set {
            if newValue {
                addSubview(gestureFilterView)
                addSubview(collapseButton)
            } else {
                gestureFilterView.removeFromSuperview()
                collapseButton.removeFromSuperview()
            }
        }
        get {
            return subviews.contains(gestureFilterView)
        }
    }
    
}

import MapKit
