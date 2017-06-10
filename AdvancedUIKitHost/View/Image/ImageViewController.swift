class ImageViewController: UIViewController {
    
    private let images = [UIImage(named: "ImageA")!, UIImage(named: "ImageB")!]
    private let gaussianRadius = 10
    private let opacity = 0.4
    private let compressSize = 50 * 1024
    private let size = (width: 100.0, height: 50.0)
    
    @IBOutlet weak var imageView: UIImageView!
    
    private let imagePickerHelper: ImagePickerHelper
    
    required init?(coder aDecoder: NSCoder) {
        imagePickerHelper = ImagePickerHelper()
        super.init(coder: aDecoder)
        imagePickerHelper.imagePickerHelperDelegate = self
    }
    
    @IBAction func addBlur(_ sender: Any) {
        imageView.image = images[0].addGaussianBlur(withRadius: gaussianRadius)
    }
    
    @IBAction func addOpacity(_ sender: Any) {
        imageView.image = images[0].setOpacity(opacity)
    }
    
    @IBAction func cropSquare(_ sender: Any) {
        imageView.image = images[0].cropSquare()
    }
    
    @IBAction func compress(_ sender: Any) {
        imageView.image = images[0].compress(withMaxSize: compressSize)
    }
    
    @IBAction func resize(_ sender: Any) {
        imageView.image = images[0].resize(toWidth: size.width, toHeight: size.height)
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        imagePickerHelper.showImagePicker()
    }
    
}

import AdvancedUIKit
import UIKit
