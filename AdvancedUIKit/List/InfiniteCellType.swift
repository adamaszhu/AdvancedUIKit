/// InfiniteCellType contains the attributes of an InfiniteCell.
/// - author: Adamas
/// - version: 1.0.0
/// - date: 24/06/2017
struct InfiniteCellType {
    
    /// The total height of the cell.
    var height: CGFloat {
        return basicHeight + (additionalHeight ?? 0)
    }
    
    /// The type of the cell.
    let type: InfiniteCell.Type
    
    /// The basic height of the cell.
    let basicHeight: CGFloat
    
    /// The height of the additional cell.
    let additionalHeight: CGFloat?
    
    /// Initialize the type.
    /// - parameter type: The type of the cell.
    /// - parameter basicHeight: The height of the cell.
    /// - parameter additionalHeight: The height of the additional cell.
    init(type: InfiniteCell.Type, basicHeight: CGFloat = 0, additionalHeight: CGFloat? = nil) {
        self.type = type
        self.basicHeight = basicHeight
        self.additionalHeight = additionalHeight
    }
    
}

import UIKit
