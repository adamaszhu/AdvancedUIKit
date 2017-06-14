class ImageViewController: UIViewController {
    
    private let images = [UIImage(named: "ImageA")!, UIImage(named: "ImageB")!]
    private let gaussianRadius = 10
    private let opacity = 0.4
    private let compressSize = 50 * 1024
    private let size = (width: 100.0, height: 50.0)
    
    @IBOutlet weak var galleryView: PageView!
    
    private let imagePickerHelper: ImagePickerHelper
    
    required init?(coder aDecoder: NSCoder) {
        imagePickerHelper = ImagePickerHelper()
        super.init(coder: aDecoder)
        imagePickerHelper.imagePickerHelperDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for image in images {
            let imageView = getImageView(ofImage: image)
            galleryView.add(imageView)
        }
    }
    
    @IBAction func addBlur(_ sender: Any) {
        guard let imageView = galleryView.subviews[galleryView.currentPageIndex] as? UIImageView else {
            return
        }
        guard let image = imageView.image else {
            return
        }
        imageView.image = image.addGaussianBlur(withRadius: gaussianRadius)
    }
    
    @IBAction func addOpacity(_ sender: Any) {
        guard let imageView = galleryView.subviews[galleryView.currentPageIndex] as? UIImageView else {
            return
        }
        guard let image = imageView.image else {
            return
        }
        imageView.image = image.setOpacity(opacity)
    }
    
    @IBAction func cropSquare(_ sender: Any) {
        guard let imageView = galleryView.subviews[galleryView.currentPageIndex] as? UIImageView else {
            return
        }
        guard let image = imageView.image else {
            return
        }
        imageView.image = image.cropSquare()
    }
    
    @IBAction func compress(_ sender: Any) {
        guard let imageView = galleryView.subviews[galleryView.currentPageIndex] as? UIImageView else {
            return
        }
        guard let image = imageView.image else {
            return
        }
        imageView.image = image.compress(withMaxSize: compressSize)
    }
    
    @IBAction func resize(_ sender: Any) {
        guard let imageView = galleryView.subviews[galleryView.currentPageIndex] as? UIImageView else {
            return
        }
        guard let image = imageView.image else {
            return
        }
        imageView.image = image.resize(toWidth: size.width, toHeight: size.height)
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        imagePickerHelper.showImagePicker()
    }
    
    @IBAction func showPreviousImage(_ sender: Any) {
        galleryView.switchToPreviousPage()
    }
    
    @IBAction func showNextImage(_ sender: Any) {
        galleryView.switchToNextPage()
    }
    
    @IBAction func removeImage(_ sender: Any) {
        galleryView.removeView(atIndex: galleryView.currentPageIndex)
    }
    
    @IBAction func removeAll(_ sender: Any) {
        galleryView.removeAllViews()
    }
    
    func getImageView(ofImage image: UIImage) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
}

import AdvancedUIKit
import UIKit
