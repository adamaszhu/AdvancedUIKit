/// Checkbox provides a customized checkbox
///
/// - author: Adamas
/// - version: 1.1.0
/// - date: 25/09/2017
final public class Checkbox: UIButton {
    
    /// The image used while the checkbox is checked.
    @IBInspectable public var checkedImage: UIImage?
    
    /// The image used while the checkbox is not checked.
    @IBInspectable public var uncheckedImage: UIImage?
    
    /// Whether the checkbox has been checked or not.
    public var isChecked: Bool {
        didSet {
            updateImage()
        }
    }
    
    /// Switch the status of the checkbox
    func switchStatus() {
        isChecked = !isChecked
    }
    
    /// Add the click event to the button
    private func addClickEvent() {
        addTarget(self, action: #selector(switchStatus), for: .touchUpInside)
    }
    
    /// Update the image according to current check status
    private func updateImage() {
        let image = isChecked ? checkedImage : uncheckedImage
        setImage(image, for: .normal)
    }
    
    public override init(frame: CGRect) {
        isChecked = false
        super.init(frame: frame)
        addClickEvent()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        isChecked = false
        super.init(coder: aDecoder)
        addClickEvent()
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        updateImage()
    }
}

import UIKit
