class ImageViewController: UIViewController {
    
    private let images = [UIImage(named: "ImageA")!, UIImage(named: "ImageB")!]
    private let gaussianRadius = 10
    private let opacity = 0.4
    private let compressSize = 50 * 1024
    private let size = (width: 200.0, height: 150.0)
    
    @IBOutlet weak var galleryView: ExpandableGalleryView!
    
    private let imagePickerHelper: ImagePickerHelper
    
    required init?(coder aDecoder: NSCoder) {
        imagePickerHelper = ImagePickerHelper()
        super.init(coder: aDecoder)
        imagePickerHelper.imagePickerHelperDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for image in images {
            galleryView.add(image: image)
        }
    }
    
    @IBAction func addBlur(_ sender: Any) {
        guard let image = galleryView.currentImage?.addGaussianBlur(withRadius: gaussianRadius) else {
            return
        }
        galleryView.refresh(image, atIndex: galleryView.currentPageIndex)
    }
    
    @IBAction func addOpacity(_ sender: Any) {
        guard let image = galleryView.currentImage?.setOpacity(opacity) else {
            return
        }
        galleryView.refresh(image, atIndex: galleryView.currentPageIndex)
    }
    
    @IBAction func cropSquare(_ sender: Any) {
        guard let image = galleryView.currentImage?.cropSquare() else {
            return
        }
        galleryView.refresh(image, atIndex: galleryView.currentPageIndex)
    }
    
    @IBAction func compress(_ sender: Any) {
        guard let image = galleryView.currentImage?.compress(withMaxSize: compressSize) else {
            return
        }
        galleryView.refresh(image, atIndex: galleryView.currentPageIndex)
    }
    
    @IBAction func resize(_ sender: Any) {
        guard let image = galleryView.currentImage?.resize(toWidth: size.width, toHeight: size.height) else {
            return
        }
        galleryView.refresh(image, atIndex: galleryView.currentPageIndex)
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
    
}

import AdvancedUIKit
import UIKit
