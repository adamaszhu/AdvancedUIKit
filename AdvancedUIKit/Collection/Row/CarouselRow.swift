/// CarouselRow presents a list of capsule items who are selectable.
///
/// - version: 1.8.0
/// - date: 11/10/21
/// - author: Adamas
open class CarouselRow<Item>: Row, CarouselRowType {


    /// Create a row
    /// - Parameters:
    ///   - item: Items to be displayed in the carosel.
    public init(items: [Item]) {
        super.init(icon: nil, title: nil)
    }
}

/// The interface of a carousel row
public protocol CarouselRowType: RowType {

}

import UIKit
