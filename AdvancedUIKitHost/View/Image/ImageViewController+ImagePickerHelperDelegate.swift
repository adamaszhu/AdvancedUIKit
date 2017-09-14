extension ImageViewController: ImagePickerHelperDelegate {
    
    func imagePickerHelper(_ imagePickerHelper: ImagePickerHelper, didCatchError error: String) {
        SystemMessageHelper.standard?.showInfo(error)
    }
    
    func imagePickerHelper(_ imagePickerHelper: ImagePickerHelper, didPick image: UIImage) {
        galleryView.add(image: image)
    }
    
}

import AdvancedUIKit
import UIKit
