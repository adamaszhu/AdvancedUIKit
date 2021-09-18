#if !os(macOS)
/// PageViewDelegate is a callback when the current page is changed.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 07/08/2019
public protocol PageViewDelegate: AnyObject {
    
    /// Change the page view index
    ///
    /// - Parameter index: The new index
    func pageView(_ pageView: PageView, didChangePageIndex index: Int)
}
#endif
