final class DataGenerator {
    
    private let itemAmount = 55
    private let pageSize = 10
    
    private var pageIndex: Int
    
    init() {
        pageIndex = 0
    }
    
    func generateFirstPage() -> Array<InfiniteItem> {
        pageIndex = 0
        return generateNextPage()
    }
    
    func generateNextPage() -> Array<InfiniteItem> {
        let items = generateItem(forPage: pageIndex)
        pageIndex = pageIndex + 1
        return items
    }
    
    private func generateItem(forPage page: Int) -> Array<InfiniteItem> {
        var items = Array<InfiniteItem>()
        for index in page * pageSize ..< (page + 1) * pageSize {
            guard index <= itemAmount else {
                return items
            }
            let cellType = index % 3 != 2 ? LabelCell.self : ImageCell.self
            items.append(InfiniteItem(item: index, type: cellType))
        }
        return items
    }
    
}

import AdvancedUIKit
