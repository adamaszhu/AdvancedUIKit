final class ImageCell: InfiniteCell {
    
    private let firstImageName = "ImageA"
    private let secondImageName = "ImageB"
    
    @IBOutlet private weak var icon: UIImageView!
    
    override func render(withItem item: Any) {
        guard let number = item as? Int else {
            return
        }
        let imageName = number % 2 == 0 ? firstImageName : secondImageName
        icon.image = UIImage(named: imageName)
    }
    
}

import AdvancedUIKit
import UIKit
