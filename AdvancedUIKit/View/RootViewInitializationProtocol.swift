/**
 * ViewIdentializationProtocol defines the action and property that a view should have.
 * - author: Adamas
 * - date: 23/04/2017
 * - version: 1.0.0
 */
public protocol ViewInitializationProtocol {
    
    /**
     * Render the views inside right after being allocated the frame.
     */
    func render()
    
    /**
     * Initialize the view.
     */
    func initialize()
    
}
