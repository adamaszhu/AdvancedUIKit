/// RootView is the root view of all customized view. It provides show and hide control and initialization control.
///
/// - author: Adamas
/// - date: 23/04/2017
/// - version: 1.0.4
open class RootView: UIView {
    
    /// Whether the view is visible or not.
    @objc public var isVisible: Bool
    
    /// The original frame of the view.
    @objc public private (set) var originalFrame: CGRect
    
    /// Whether the view has been initialized or not.
    private var isInitialized: Bool
    
    /// Show the view.
    @objc open func show() {
        isVisible = true
    }
    
    /// Hide the view.
    @objc open func hide() {
        isVisible = false
    }
    
    /// Initialize the view.
    @objc open func initialize() {}
    
    /// Render the views inside right after being allocated the frame.
    @objc open func render() {}
    
    public required init?(coder aDecoder: NSCoder) {
        isInitialized = false
        isVisible = true
        originalFrame = .init(x: 0, y: 0, width: 0, height: 0)
        super.init(coder: aDecoder)
        initialize()
    }
    
    public override init(frame: CGRect) {
        isInitialized = false
        isVisible = true
        originalFrame = frame
        super.init(frame: frame)
        initialize()
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard !isInitialized else {
            return
        }
        isInitialized = true
        originalFrame = frame
        render()
    }
    
}

import UIKit
