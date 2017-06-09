/**
 * ExpandableMapView is used to add full screen function to the map view.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 09/06/2017
 */
public class ExpandableMapView: MapView {
    
    /**
     * System error.
     */
    private static let superviewError = "The superview is nil."
    private static let windowError = "The window is nil."
    
    /**
     * System warning.
     */
    private static let expandWarning = "The view has been expanded."
    private static let collapseWarning = "The view has been collapsed."
    
    /**
     * The gesture filter to expand the view.
     */
    private let gestureFilterView: UIView
    
    /**
     * The origin superview.
     */
    private var originSuperview: UIView!
    
    /**
     * The z Index.
     */
    private var zIndex: Int!
    
    /**
     * The origin frame in origin view.
     */
    private var originFrame: CGRect!
    
    /**
     * Whether the view can be expanded or not.
     */
    public var isExpandable: Bool {
        set {
            guard superview != nil else {
                Logger.standard.logError(ExpandableMapView.superviewError)
                return
            }
            if newValue {
                addSubview(gestureFilterView)
            } else {
                gestureFilterView.removeFromSuperview()
            }
        }
        get {
            return subviews.contains(gestureFilterView)
        }
    }
    
    /**
     * Whether the view is expanded or not.
     */
    public var isExpanded: Bool {
        guard superview != nil else {
            Logger.standard.logError(ExpandableMapView.superviewError)
            return false
        }
        return superview == window
    }
    
    /**
     * Expand the view.
     */
    public func expand() {
        guard !isExpanded && isExpandable else {
            Logger.standard.logWarning(ExpandableMapView.expandWarning)
            return
        }
        guard let superview = superview else {
            Logger.standard.logError(ExpandableMapView.superviewError)
            return
        }
        guard let window = window else {
            Logger.standard.logError(ExpandableMapView.windowError)
            return
        }
        originSuperview = superview
        zIndex = superview.subviews.index(of: self)
        originFrame = frame
        animate(withChange: { [unowned self] _ in
            self.frame = window.bounds
            }, withPreparation: { [unowned self] _ in
                self.gestureFilterView.isHidden = true
                self.moveToWindow()
            }, withCompletion: { [unowned self] _ in
                self.perform(#selector(self.collapse), with: nil, afterDelay: 3)
        })
    }
    
    /**
     * Collapse the view.
     */
    public func collapse() {
        guard isExpanded && isExpandable else {
            Logger.standard.logWarning(ExpandableMapView.collapseWarning)
            return
        }
        guard let window = window else {
            Logger.standard.logError(ExpandableMapView.windowError)
            return
        }
        animate(withChange: { [unowned self] _ in
            self.frame = window.convert(self.originFrame, from: self.originSuperview)
            }, withCompletion: { [unowned self] _ in
                self.removeFromWindow()
                self.gestureFilterView.isHidden = false
        })
    }
    
    /**
     * Move current view to the window.
     */
    private func moveToWindow() {
        guard let window = window else {
            Logger.standard.logError(ExpandableMapView.windowError)
            return
        }
        deactivateFrameConstraints()
        removeFromSuperview()
        window.addSubview(self)
        frame = window.convert(originFrame, from: originSuperview)
        translatesAutoresizingMaskIntoConstraints = true
    }
    
    /**
     * Remove the view from window and move it back to its original superview.
     */
    private func removeFromWindow() {
//        translatesAutoresizingMaskIntoConstraints = false
        removeFromSuperview()
        originSuperview.insertSubview(self, at: zIndex)
//        activateFrameConstraints()
        frame = originFrame
    }
    
    /**
     * MapView
     */
    public required init?(coder aDecoder: NSCoder) {
        gestureFilterView = UIView()
        super.init(coder: aDecoder)
        gestureFilterView.frame = bounds
        gestureFilterView.backgroundColor = UIColor.clear
        let expandGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(expand))
        gestureFilterView.addGestureRecognizer(expandGestureRecognizer)
    }
    
}

import MapKit
