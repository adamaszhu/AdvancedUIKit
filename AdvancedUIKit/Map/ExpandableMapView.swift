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
     * The button used to collapse the view.
     */
    private let collapseButton: UIButton
    
    /**
     * The original superview.
     */
    private var originalSuperview: UIView!
    
    /**
     * The original z Index.
     */
    private var originalZIndex: Int!
    
    /**
     * The origin frame in origin view.
     */
    private var originalFrame: CGRect!
    
    /**
     * The original frame related constraints on the superview.
     */
    private var originalFrameConstraints: Array<NSLayoutConstraint>!
    
    /**
     * The original constraints.
     */
    private var originalConstraints: Array<NSLayoutConstraint>!
    
    /**
     * Whether the view can be expanded or not.
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
        originalSuperview = superview
        originalZIndex = superview.subviews.index(of: self)
        originalFrame = frame
        originalFrameConstraints = frameConstraints
        // TODO: Exclude those constraints related to subviews.
        originalConstraints = constraints
        animate(withChange: { [unowned self] _ in
            self.frame = window.bounds
            }, withPreparation: { [unowned self] _ in
                self.gestureFilterView.isHidden = true
                self.moveToWindow()
            }, withCompletion: { [unowned self] _ in
                self.collapseButton.isHidden = false
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
            self.frame = window.convert(self.originalFrame, from: self.originalSuperview)
            }, withPreparation: { [unowned self] _ in
                self.collapseButton.isHidden = true
            }, withCompletion: { [unowned self] _ in
                self.removeFromWindow()
                self.gestureFilterView.isHidden = false
        })
    }
    
    /**
     * Wait until the view has been added back to the original superview and add constraints.
     */
    func addOriginalConstraints() {
        guard let superview = superview else {
            Logger.standard.logError(ExpandableMapView.superviewError)
            return
        }
        superview.addConstraints(originalFrameConstraints)
        addConstraints(originalConstraints)
    }
    
    /**
     * Move current view to the window.
     */
    private func moveToWindow() {
        guard let window = window else {
            Logger.standard.logError(ExpandableMapView.windowError)
            return
        }
        guard let superview = superview else {
            Logger.standard.logError(ExpandableMapView.superviewError)
            return
        }
        superview.removeConstraints(originalFrameConstraints)
        removeConstraints(originalConstraints)
        removeFromSuperview()
        window.addSubview(self)
        frame = window.convert(originalFrame, from: originalSuperview)
        translatesAutoresizingMaskIntoConstraints = true
    }
    
    /**
     * Remove the view from window and move it back to its original superview.
     */
    private func removeFromWindow() {
        translatesAutoresizingMaskIntoConstraints = false
        removeFromSuperview()
        originalSuperview.insertSubview(self, at: originalZIndex)
        addOriginalConstraints()
        // COMMENT: Wait the view to be refreshed and add the constraint back
        perform(#selector(addOriginalConstraints), with: nil, afterDelay: 0.2)
    }
    
    /**
     * MapView
     */
    public required init?(coder aDecoder: NSCoder) {
        gestureFilterView = UIView()
        collapseButton = UIButton()
        super.init(coder: aDecoder)
        collapseButton.frame = bounds
        collapseButton.isHidden = true
        collapseButton.addTarget(self, action: #selector(collapse), for: .touchUpInside)
        gestureFilterView.frame = bounds
        gestureFilterView.backgroundColor = UIColor.clear
        let expandGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(expand))
        gestureFilterView.addGestureRecognizer(expandGestureRecognizer)
    }
    
}

import MapKit
