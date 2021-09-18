#if !os(macOS)
/// RootView is the root view of all customized view. It provides show and hide control and initialization control.
///
/// - author: Adamas
/// - date: 05/08/2019
/// - version: 1.5.0
open class RootView: UIView {
    
    /// Whether the view is visible or not.
    public var isVisible: Bool = true
    
    /// The original frame of the view.
    public private (set) var originalFrame: CGRect = .zero
    
    /// Whether the view has been initialized or not.
    private var isInitialized: Bool = false
    
    /// Show the view.
    open func show() {
        if isVisible {
            Logger.standard.logWarning(Self.showingWarning)
        }
        isVisible = true
    }
    
    /// Hide the view.
    open func hide() {
        if !isVisible {
            Logger.standard.logWarning(Self.hidingWarning)
        }
        isVisible = false
    }
    
    /// Initialize the view.
    open func initialize() {}
    
    /// Render the views inside right after being allocated the frame.
    open func render() {}
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    public override init(frame: CGRect) {
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

/// Constants
extension RootView {
    
    /// System warning.
    static let showingWarning = "The view has already been shown."
    static let hidingWarning = "The view has already been hidden."
}

import AdvancedFoundation
import UIKit
#endif
