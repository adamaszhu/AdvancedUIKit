extension ImageViewController: ImagePickerHelperDelegate {
    
    func imagePickerHelper(_ imagePickerHelper: ImagePickerHelper, didCatchError error: String) {
        SystemMessageHelper.standard?.showInfo(error)
    }
    
    func imagePickerHelper(_ imagePickerHelper: ImagePickerHelper, didPickImage image: UIImage) {
        imageView.image = image
    }
    
}

import AdvancedUIKit
import UIKit
