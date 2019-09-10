final class ImageViewController: UIViewController {
    
    private let cameraHelper: CameraHelper = CameraHelper()
    private let messageHelper: SystemMessageHelper? = SystemMessageHelper()
    
    @IBOutlet private weak var galleryView: ExpandableGalleryView!
    
    private lazy var imagePickerHelper: ImagePickerHelper = {
        let imagePickerHelper = ImagePickerHelper()
        imagePickerHelper.imagePickerHelperDelegate = self
        return imagePickerHelper
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        galleryView.isExpandable = true
        ImageViewController.images.forEach {
            galleryView.add($0)
        }
    }
    
    @IBAction func requestCameraAuthorization(_ sender: Any) {
        cameraHelper.requestCameraAuthorization()
    }
    
    @IBAction func requestLibraryAuthorization(_ sender: Any) {
        cameraHelper.requestLibraryAuthorization()
    }
    
    @IBAction func addBlur(_ sender: Any) {
        guard let image = galleryView.currentImage?.addingGaussianBlur(withRadius: ImageViewController.gaussianRadius) else {
            return
        }
        galleryView.refresh(image, atIndex: galleryView.currentPageIndex)
    }
    
    @IBAction func addOpacity(_ sender: Any) {
        guard let image = galleryView.currentImage?.addingOpacity(ImageViewController.opacity) else {
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
        guard let image = galleryView.currentImage?.compressing(withMaxSize: ImageViewController.compressSize) else {
            return
        }
        galleryView.refresh(image, atIndex: galleryView.currentPageIndex)
    }
    
    @IBAction func resize(_ sender: Any) {
        guard let image = galleryView.currentImage?.resizing(toWidth: ImageViewController.size.width, andHeight: ImageViewController.size.height) else {
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

extension ImageViewController: ImagePickerHelperDelegate {
    
    func imagePickerHelper(_ imagePickerHelper: ImagePickerHelper, didCatchError error: String) {
        messageHelper?.showInfo(error)
    }
    
    func imagePickerHelper(_ imagePickerHelper: ImagePickerHelper, didPick image: UIImage) {
        galleryView.add(image)
    }
}

private extension ImageViewController {
    static let images = [UIImage(named: "ImageA")!, UIImage(named: "ImageB")!]
    static let gaussianRadius = 10
    static let opacity = 0.4
    static let compressSize = 50 * 1024
    static let size = CGSize(width: 800, height: 400)
}

import AdvancedUIKit
import UIKit
