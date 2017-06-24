/**
 * InfiniteCellType contains the attributes of an InfiniteCell
 * - author: Adamas
 * - version: 1.0.0
 * - date: 24/06/2017
 */
struct InfiniteCellType {
    
    /*
     * The type of the cell.
     */
    let type: InfiniteCell.Type
    
    /**
     * The height of the cell.
     */
    let height: CGFloat
    
    /**
     * The height of the additional cell.
     */
    let additionalHeight: CGFloat?
    
    /**
     * Initialize the type.
     * - parameter type: The type of the cell.
     * - parameter height: The height of the cell.
     * - parameter additionalHeight: The height of the additional cell.
     */
    init(type: InfiniteCell.Type, height: CGFloat = 0, additionalHeight: CGFloat? = nil) {
        self.type = type
        self.height = height
        self.additionalHeight = additionalHeight
    }
    
}

import UIKit
