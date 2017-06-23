class ImageCell: InfiniteCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func render(_ item: Any) {
        label.text = "\(item)"
        guard let number = item as? Int else {
            return
        }
        if number % 2 == 0 {
            icon.image = UIImage(named: "ImageA")
        } else {
            icon.image = UIImage(named: "ImageB")
        }
    }
    
}

import AdvancedUIKit
import UIKit
