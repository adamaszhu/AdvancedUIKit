/// PageViewDelegate is a callback when the current page is changed.
///
/// - author: Adamas
/// - version: 1.3.0
/// - date: 03/07/2018
protocol PageViewDelegate {
    
    /// Change the page view index
    ///
    /// - Parameter index: The new index
    func pageView(_ pageView: PageView, didChangeCurrentIndex index: Int)
    
}

import Foundation
