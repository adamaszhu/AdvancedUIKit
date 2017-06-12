extension ImageViewController: ImagePickerHelperDelegate {
    
    func imagePickerHelper(_ imagePickerHelper: ImagePickerHelper, didCatchError error: String) {
        SystemMessageHelper.standard?.showInfo(error)
    }
    
    func imagePickerHelper(_ imagePickerHelper: ImagePickerHelper, didPickImage image: UIImage) {
        let imageView = getImageView(ofImage: image)
        galleryView.add(imageView)
    }
    
}

import AdvancedUIKit
import UIKit
