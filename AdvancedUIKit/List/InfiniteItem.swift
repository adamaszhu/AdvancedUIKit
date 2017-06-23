/**
 * InfiniteItem defines an item rendered by the cell.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 23/06/2017
 */
public struct InfiniteItem {
    
    /**
     * The real data.
     */
    let item: Any
    
    /*
     * The type of the cell.
     */
    let type: InfiniteCell.Type
    
    /**
     * Initialise the object.
     * - parameter item: The item associated to the cell.
     * - parameter type: The type of the cell.
     */
    public init(item: Any, type: InfiniteCell.Type) {
        self.item = item
        self.type = type
    }
    
}
