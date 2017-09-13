/// RootView is the root view of all customized view. It provides show and hide control and initialization control.
///
/// - author: Adamas
/// - date: 23/04/2017
/// - version: 1.0.0
open class RootView: UIView {
    
    /// System warning.
    static let showingWarning = "The view has already been shown."
    static let hidingWarning = "The view has already been hidden."
    
    /// Whether the view is visible or not.
    public var isVisible: Bool
    
    /// The original frame of the view.
    private (set) var originalFrame: CGRect
    
    /// Whether the view has been initialized or not.
    private var isInitialized: Bool
    
    /// Show the view.
    open func show() {
        isVisible = true
    }
    
    /// Hide the view.
    open func hide() {
        isVisible = false
    }
    
    /// Initialize the view.
    open func initialize() {}
    
    /// Render the views inside right after being allocated the frame.
    open func render() {}
    
    public required init?(coder aDecoder: NSCoder) {
        isInitialized = false
        isVisible = true
        originalFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
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
        if isInitialized {
            return
        }
        isInitialized = true
        originalFrame = frame
        render()
    }
    
}

import UIKit
