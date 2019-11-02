/// ExpandableMapView is used to add full screen function to the map view.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 09/09/2019
final public class ExpandableMapView: MapView {
    
    /// The gesture filter to expand the view.
    private let gestureFilterView: UIView = UIView()
    
    /// The button used to collapse the view.
    private let collapseButton: UIButton = UIButton()
    
    /// The blur effect background of the collapse button.
    private let collapseButtonBackgroundView: UIVisualEffectView = UIVisualEffectView()
    
    /// The icon on the collapse button.
    public var collapseIcon: UIImage? {
        set {
            guard let newImage = newValue else {
                return
            }
            collapseButton.setImage(newImage, for: .normal)
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
            collapseButtonBackgroundView.clipsToBounds = true
        }
        get {
            return Int(collapseButtonBackgroundView.layer.cornerRadius)
        }
    }
    
    /// The background margin.
    public var collapseButtonBackgroundMargin: Int {
        set {
            let margin = CGFloat(newValue)
            collapseButtonBackgroundView.frame.origin = CGPoint(x: collapseButton.frame.origin.x - margin, y: collapseButton.frame.origin.y - margin)
            collapseButtonBackgroundView.frame.size = CGSize(width: collapseButton.frame.width + 2 * margin, height: collapseButton.frame.height + 2 * margin)
        }
        get {
            let margin = collapseButtonBackgroundView.frame.origin.x - collapseButton.frame.origin.x
            return abs(Int(margin))
        }
    }
    
    /// Initialize the object.
    private func initialize() {
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
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initialize()
    }
}

/// ExpandableView
extension ExpandableMapView: ExpandableView {
    
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
    
    var isExpanded: Bool {
        guard let _ = superview else {
            Logger.standard.logError(ExpandableMapView.superviewError)
            return false
        }
        return superview == window
    }
    
    @objc public func expand() {
        guard !isExpanded, isExpandable else {
            Logger.standard.logWarning(ExpandableMapView.expandingWarning)
            return
        }
        guard let window = window else {
            Logger.standard.logError(ExpandableMapView.windowError)
            return
        }
        saveOriginalConstraints(of: self)
        animateChange({ [weak self] in
            self?.frame = window.bounds
            self?.collapseButton.alpha = 1
            self?.collapseButtonBackgroundView.alpha = 1
            }, preparation: { [weak self] in
                guard let self = self else {
                    return
                }
                self.gestureFilterView.isHidden = true
                self.moveToWindow(of: self)
                self.collapseButton.isHidden = false
                self.collapseButton.alpha = 0
                self.collapseButton.isUserInteractionEnabled = false
                self.collapseButtonBackgroundView.isHidden = false
                self.collapseButtonBackgroundView.alpha = 0
            }) { [weak self] in
                self?.collapseButton.alpha = 1
                self?.collapseButton.isUserInteractionEnabled = true
                self?.collapseButtonBackgroundView.alpha = 1
        }
    }
    
    @objc public func collapse() {
        guard isExpanded, isExpandable else {
            Logger.standard.logWarning(ExpandableMapView.collapsingWarning)
            return
        }
        guard let window = window else {
            Logger.standard.logError(ExpandableMapView.windowError)
            return
        }
        animateChange({ [weak self] in
            guard let self = self else {
                return
            }
            self.frame = window.convert(self.originalFrame, from: self.originalSuperview)
            self.collapseButton.alpha = 0
            self.collapseButtonBackgroundView.alpha = 0
            }, preparation: { [weak self] in
                self?.collapseButton.alpha = 1
                self?.collapseButton.isUserInteractionEnabled = false
                self?.collapseButtonBackgroundView.alpha = 1
            }) { [weak self] in
                guard let self = self else {
                    return
                }
                self.collapseButton.alpha = 1
                self.collapseButton.isUserInteractionEnabled = true
                self.collapseButton.isHidden = true
                self.collapseButtonBackgroundView.isHidden = true
                self.collapseButtonBackgroundView.alpha = 1
                self.removeFromWindow(of: self)
                self.gestureFilterView.isHidden = false
        }
    }
}

import AdvancedFoundation
import MapKit
