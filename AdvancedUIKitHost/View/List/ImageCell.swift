final class ImageCell: InfiniteCell {
    
    @IBOutlet private weak var icon: UIImageView!
    
    override func render(withItem item: Any) {
        guard let number = item as? Int else {
            return
        }
        let imageName = number % 2 == 0 ? ImageCell.firstImageName : ImageCell.secondImageName
        icon.image = UIImage(named: imageName)
    }
}

private extension ImageCell {
    static let firstImageName = "ImageA"
    static let secondImageName = "ImageB"
}

import AdvancedUIKit
import UIKit
