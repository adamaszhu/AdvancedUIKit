final class ImageViewController: UIViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    private let cameraHelper: CameraHelper = CameraHelper()
    private let deviceHelper: DeviceHelper = DeviceHelper()
    private var codeType: CodeType = .qr
    
    private lazy var messageHelper: SystemMessageHelper? = {
        let messageHelper = SystemMessageHelper()
        messageHelper?.delegate = self
        return messageHelper
    }()
    
    @IBOutlet private weak var galleryView: ExpandableGalleryView!
    
    private lazy var imagePickerHelper: ImagePickerHelper = {
        let imagePickerHelper = ImagePickerHelper()
        imagePickerHelper.delegate = self
        return imagePickerHelper
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        galleryView.isExpandable = true
        galleryView.images = ImageViewController.images
    }
    
    @IBAction func requestCameraAuthorization(_ sender: Any) {
        if cameraHelper.isCameraUndetermined {
            cameraHelper.requestCameraAuthorization()
        } else {
            deviceHelper.openSystemSetting()
        }
    }
    
    @IBAction func requestLibraryAuthorization(_ sender: Any) {
        if cameraHelper.isLibraryUndetermined {
            cameraHelper.requestLibraryAuthorization()
        } else {
            deviceHelper.openSystemSetting()
        }
    }
    
    @IBAction func addBlur(_ sender: Any) {
        guard let image = galleryView.currentImage?.addingGaussianBlur(withRadius: Self.gaussianRadius) else {
            return
        }
        galleryView.refresh(image, atIndex: galleryView.currentPageIndex)
    }
    
    @IBAction func addOpacity(_ sender: Any) {
        guard let image = galleryView.currentImage?.addingOpacity(Self.opacity) else {
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
    
    @IBAction func takeScreenshot(_ sender: Any) {
        if let screenshot = view.screenshot() {
            galleryView.add(screenshot)
        }
    }
    
    @IBAction func takeScrollableScreenshot(_ sender: Any) {
        if let screenshot = scrollView.contentScreenshot() {
            galleryView.add(screenshot)
        }
    }
    
    @IBAction func joinImages(_ sender: Any) {
        if let screenshot1 = view.screenshot(), let screenshot2 = view.screenshot(), let screenshot = screenshot1.concat(screenshot2, with: .horizontalTop) {
            galleryView.add(screenshot)
        }
    }
    
    @IBAction func addCode128Barcode(_ sender: Any) {
        codeType = .code128
        messageHelper?.showInput(withTitle: ImageViewController.codeInputTitle)
    }
    
    @IBAction func addPDF417BarCode(_ sender: Any) {
        codeType = .pdf417
        messageHelper?.showInput(withTitle: ImageViewController.codeInputTitle)
    }
    
    @IBAction func addAZTECCode(_ sender: Any) {
        codeType = .aztec
        messageHelper?.showInput(withTitle: ImageViewController.codeInputTitle)
    }
    
    @IBAction func addQRCode(_ sender: Any) {
        codeType = .qr
        messageHelper?.showInput(withTitle: ImageViewController.codeInputTitle)
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

extension ImageViewController: MessageHelperDelegate {
    
    func messageHelper(_ messageHelper: MessageHelper, didConfirmInput content: String) {
        let codeHelper = CodeHelper()
        if let image = codeHelper.createCode(content, as: codeType, with: ImageViewController.size) {
            if #available(iOS 14, *) {
                galleryView.imageMode = .scaleToFill
                galleryView.add(image)
                galleryView.imageMode = .scaleAspectFit
            } else {
                galleryView.add(image)
            }
        }
    }
}

private extension ImageViewController {
    static let images = [UIImage(named: "ImageA")!, UIImage(named: "ImageB")!]
    static let gaussianRadius = 10
    static let opacity = 0.4
    static let compressSize = 50 * 1024
    static let size = CGSize(width: 800, height: 400)
    static let codeInputTitle = "Input the code"
}

import AdvancedUIKit
import UIKit
