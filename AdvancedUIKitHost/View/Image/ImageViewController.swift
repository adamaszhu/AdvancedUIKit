final class ImageViewController: UIViewController {
    
    private let images = [UIImage(named: "ImageA")!, UIImage(named: "ImageB")!]
    private let gaussianRadius = 10
    private let opacity = 0.4
    private let compressSize = 50 * 1024
    private let size = (width: 800.0, height: 400.0)
    
    @IBOutlet weak var galleryView: ExpandableGalleryView!
    
    private lazy var imagePickerHelper: ImagePickerHelper = {
        let imagePickerHelper = ImagePickerHelper()
        imagePickerHelper.imagePickerHelperDelegate = self
        return imagePickerHelper
    }()
    
    private let cameraHelper = CameraHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        galleryView.isExpandable = true
        images.forEach {
            galleryView.add(image: $0)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cameraHelper.requestCameraAuthorization()
        cameraHelper.requestLibraryAuthorization()
    }
    
    @IBAction func addBlur(_ sender: Any) {
        guard let image = galleryView.currentImage?.addingGaussianBlur(withRadius: gaussianRadius) else {
            return
        }
        galleryView.refresh(image, atIndex: galleryView.currentPageIndex)
    }
    
    @IBAction func addOpacity(_ sender: Any) {
        guard let image = galleryView.currentImage?.addingOpacity(opacity) else {
            return
        }
        galleryView.refresh(image, atIndex: galleryView.currentPageIndex)
    }
    
    @IBAction func cropSquare(_ sender: Any) {
        guard let image = galleryView.currentImage?.croppingSquare() else {
            return
        }
        galleryView.refresh(image, atIndex: galleryView.currentPageIndex)
    }
    
    @IBAction func compress(_ sender: Any) {
        guard let image = galleryView.currentImage?.compressing(withMaxSize: compressSize) else {
            return
        }
        galleryView.refresh(image, atIndex: galleryView.currentPageIndex)
    }
    
    @IBAction func resize(_ sender: Any) {
        guard let image = galleryView.currentImage?.resizing(toWidth: size.width, toHeight: size.height) else {
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
