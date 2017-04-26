/**
 * RootView is the root view of all customized view. It provides show and hide control and initialization control.
 * - author: Adamas
 * - date: 23/04/2017
 * - version: 1.0.0
 */
open class RootView: UIView {
    
    /**
     * Whether the view is visible or not.
     */
    public var isVisible: Bool
    
    /**
     * The original frame of the view.
     */
    private (set) var originalFrame: CGRect
    
    /**
     * Whether the view has been initialized or not.
     */
    private var isInitialized: Bool
    
    /**
     * Override.
     */
    public required init?(coder aDecoder: NSCoder) {
        isInitialized = false
        isVisible = true
        originalFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
        super.init(coder: aDecoder)
        initialize()
    }
    
    /**
     * Override.
     */
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        if isInitialized {
            return
        }
        isInitialized = true
        originalFrame = rect
        render()
    }
    
    /**
     * ViewVisibilityProtocol.
     */
    open func show() {
        isVisible = true
    }
    
    /**
     * ViewVisibilityProtocol.
     */
    open func hide() {
        isVisible = false
    }
    
    /**
     * ViewInitializationProtocol.
     */
    open func initialize() {}
    
    /**
     * ViewInitializationProtocol.
     */
    open func render() {}
    
}

import UIKit
