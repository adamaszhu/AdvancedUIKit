/// CustomizedMessageHelper is used to display a customized message on the screen.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 05/09/2019
final public class CustomizedMessageHelper: PopupView {
    
    /// MessageHelper
    public weak var messageHelperDelegate: MessageHelperDelegate?
    
    /// The mask color.
    public var maskColor: UIColor? {
        set {
            backgroundColor = newValue
        }
        get {
            return backgroundColor
        }
    }
    
    /// The background color of the message frame.
    public var frameColor: UIColor? {
        set {
            frameView.backgroundColor = newValue
        }
        get {
            return frameView.backgroundColor
        }
    }
    
    /// The visibility of the second button.
    private var isCancelButtonVisible: Bool {
        set {
            let confirmButtonWidth = newValue ? buttonView.frame.width / 2 : buttonView.frame.width
            confirmButton.frame = CGRect(x: buttonView.frame.width - confirmButtonWidth, y: confirmButton.frame.origin.y, width: confirmButtonWidth, height: confirmButton.frame.height)
            cancelButton.isHidden = !newValue
            buttonSeperatorView.isHidden = !newValue
        }
        get {
            return !cancelButton.isHidden
        }
    }
    
    /// The title of the message.
    private var title: String? {
        set {
            let title = newValue?.isEmpty == true ? nil : newValue
            titleLabel.text = title
            titleLabel.frame.size = CGSize(width: titleLabel.frame.width, height: titleLabel.actualHeight)
            let titleViewY = title == nil ? CustomizedMessageHelper.padding : CustomizedMessageHelper.padding * 2
            titleView.frame = CGRect(x: titleView.frame.origin.x, y: titleViewY, width: titleView.frame.width, height: titleLabel.frame.height)
        }
        get {
            return titleLabel.text
        }
    }
    
    /// The content height.
    private var contentHeight: CGFloat {
        set {
            let contentViewY = titleView.frame.height + titleView.frame.origin.y + CustomizedMessageHelper.padding
            contentView.frame = CGRect(x: contentView.frame.origin.x ,y: contentViewY, width: contentView.frame.width, height: newValue)
            let buttonViewY = contentViewY + contentView.frame.height + CustomizedMessageHelper.padding * 1.5
            buttonView.frame.origin = CGPoint(x: buttonView.frame.origin.x, y: buttonViewY)
            let frameHeight = buttonViewY + buttonView.frame.height
            frameView.frame = CGRect(x: frameView.frame.origin.x, y: (frame.height - frameHeight) / 2, width: frameView.frame.width, height: frameHeight)
        }
        get {
            return contentView.frame.height - CustomizedMessageHelper.padding * 2
        }
    }
    
    /// The type of current message.
    private var messageType: MessageType = .unknown
    
    /// The components of a customized view.
    private var frameView: UIView = UIView()
    private var titleView: UIView = UIView()
    private var titleLabel: UILabel = UILabel()
    private var contentView: UIView = UIView()
    private var messageLabel: UILabel = UILabel()
    private var inputText: UITextField = UITextField()
    private var buttonView: UIView = UIView()
    private var cancelButton: UIButton = UIButton()
    private var confirmButton: UIButton = UIButton()
    private var buttonSeperatorView: UIView = UIView()
    
    /// Display a customized message.
    ///
    /// - Parameters:
    ///   - title: The title.
    ///   - content: The content of the message. If it is nil, then it will be an input message
    ///   - confirmButtonName: The name of the confirm button. If this is nil, the confirm button will not be shown.
    ///   - cancelButtonName: The name of the cancel button.
    private func showMessage(withTitle title: String, content: String?, confirmButtonName: String, andCancelButtonName cancelButtonName: String?) {
        let title = title.localizedInternalString(forType: MessageHelper.self)
        let confirmButtonName = confirmButtonName.localizedInternalString(forType: MessageHelper.self)
        let cancelButtonName = cancelButtonName?.localizedInternalString(forType: MessageHelper.self)
        
        self.title = title
        messageLabel.text = content
        confirmButton.title = confirmButtonName
        let isInput = content == nil
        messageLabel.isHidden = isInput
        inputText.isHidden = !isInput
        if isInput {
            inputText.placeholder = CustomizedMessageHelper.inputHint + title.lowercased()
            inputText.placeholderColor = CustomizedMessageHelper.defaultInputPlaceHolderColor
            contentHeight = inputText.frame.height
        } else {
            messageLabel.text = content
            let messageHeight = messageLabel.actualHeight > frame.height * CustomizedMessageHelper.maxHeightWeight ? frame.height * CustomizedMessageHelper.maxHeightWeight : messageLabel.actualHeight
            messageLabel.frame.size = CGSize(width: messageLabel.frame.width, height: messageHeight)
            contentHeight = messageLabel.frame.height
        }
        if let cancelButtonName = cancelButtonName {
            isCancelButtonVisible = true
            cancelButton.title = cancelButtonName
        } else {
            isCancelButtonVisible = false
        }
        show()
    }
    
    /// Initialize the object
    public init() {
        super.init()
        backgroundColor = CustomizedMessageHelper.defaultMaskBackgroundColor
        let contentWidth = frame.width * CustomizedMessageHelper.widthWeight - CustomizedMessageHelper.padding * 2
        // The height of messageLabel, contentView
        // The y location of messageView and buttonView will be settled dynamically later.
        // Frame view. The height and Y will be changed later.
        frameView.frame = CGRect(x: frame.width * (1 - CustomizedMessageHelper.widthWeight) / 2, y: 0, width: frame.width * CustomizedMessageHelper.widthWeight, height: 0)
        frameView.backgroundColor = CustomizedMessageHelper.defaultMessageBackgroundColor
        frameView.layer.cornerRadius = CustomizedMessageHelper.radius
        addSubview(frameView)
        // Title label. The height will be changed later.
        titleLabel.frame = CGRect(x: 0, y: 0, width: contentWidth, height: 0)
        titleLabel.textColor = CustomizedMessageHelper.defaultTextColor
        titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize)
        titleLabel.textAlignment = .center
        titleView.addSubview(titleLabel)
        // Title view. The height and Y will be changed later.
        titleView.frame = CGRect(x: CustomizedMessageHelper.padding, y: 0, width: contentWidth, height: 0)
        frameView.addSubview(titleView)
        // Message label. The height will be changed later.
        messageLabel.frame = CGRect(x: 0, y: 0, width: contentWidth, height: 0)
        messageLabel.textColor = CustomizedMessageHelper.defaultTextColor
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        contentView.addSubview(messageLabel)
        // Input text.
        inputText.frame = CGRect(x: 0, y: 0, width: contentWidth, height: inputText.lineHeight)
        inputText.textColor = CustomizedMessageHelper.defaultTextColor
        inputText.tintColor = CustomizedMessageHelper.defaultTextColor
        inputText.textAlignment = .center
        contentView.addSubview(inputText)
        // Content view. The height and Y will be changed later.
        contentView.frame = CGRect(x: CustomizedMessageHelper.padding, y: 0, width: contentWidth, height: 0)
        frameView.addSubview(contentView)
        // Line view.
        let lineView = UIView()
        lineView.backgroundColor = CustomizedMessageHelper.defaultSeperatorColor
        lineView.frame = CGRect(x: CustomizedMessageHelper.padding, y: 0, width: contentWidth, height: 1)
        buttonView.addSubview(lineView)
        // First button and second button.
        cancelButton.title = .empty
        cancelButton.frame = CGRect(x: 0, y: lineView.frame.size.height, width: frameView.frame.width / 2, height: cancelButton.lineHeight + CustomizedMessageHelper.padding * 2)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        buttonView.addSubview(cancelButton)
        confirmButton.title = .empty
        confirmButton.frame = CGRect(x: cancelButton.frame.width, y: lineView.frame.height, width: cancelButton.frame.width, height: cancelButton.frame.height)
        confirmButton.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        buttonView.addSubview(confirmButton)
        // Button seperate view.
        buttonSeperatorView.frame = CGRect(x: confirmButton.frame.origin.x, y: lineView.frame.size.height + CustomizedMessageHelper.padding / 2, width: 1, height: confirmButton.frame.height - CustomizedMessageHelper.padding)
        buttonSeperatorView.backgroundColor = CustomizedMessageHelper.defaultSeperatorColor
        buttonView.addSubview(buttonSeperatorView)
        // Button view. The Y will be changed later.
        buttonView.frame = CGRect(x: 0, y: 0, width: frameView.frame.width, height: lineView.frame.size.height + confirmButton.frame.size.height)
        frameView.addSubview(buttonView)
    }
    
    /// A message has been confirmed.
    @objc private func confirm() {
        switch messageType {
        case .info:
            break
        case .warning:
            messageHelperDelegate?.messageHelperDidConfirmWarning(self)
            break
        case .error:
            messageHelperDelegate?.messageHelperDidConfirmError(self)
            break
        case .input:
            messageHelperDelegate?.messageHelper(self, didConfirmInput: inputText.text ?? .empty)
            inputText.text = .empty
            break
        case .unknown:
            Logger.standard.logError(CustomizedMessageHelper.typeError)
            break
        }
        hide()
    }
    
    /// A message has been cancelled.
    @objc private func cancel() {
        switch messageType {
        case .info, .error:
            break
        case .warning:
            messageHelperDelegate?.messageHelperDidCancelWarning(self)
            break
        case .input:
            messageHelperDelegate?.messageHelperDidCancelInput(self)
            inputText.text = .empty
            break
        case .unknown:
            Logger.standard.logError(CustomizedMessageHelper.typeError)
            break
        }
        hide()
    }
    
    /// Hide previous message.
    private func hidePreviousMessage() {
        guard messageType != .unknown else {
            Logger.standard.logError(CustomizedMessageHelper.typeError)
            return
        }
        messageType = .unknown
        hide()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        Logger.standard.logError(CustomizedMessageHelper.initError)
        return nil
    }
}

/// MessageHelper
extension CustomizedMessageHelper: MessageHelper {
    
    public func showInfo(_ content: String, withTitle title: String = successTitle, withConfirmButtonName confirmButtonName: String = infoConfirmButtonName) {
        hidePreviousMessage()
        messageType = .info
        showMessage(withTitle: title, content: content, confirmButtonName: confirmButtonName, andCancelButtonName: nil)
    }
    
    public func showWarning(_ content: String, withTitle title: String = warningTitle, withConfirmButtonName confirmButtonName: String = warningConfirmButtonName, withCancelButtonName cancelButtonName: String = warningCancelButtonName) {
        hidePreviousMessage()
        messageType = .warning
        showMessage(withTitle: title, content: content, confirmButtonName: confirmButtonName, andCancelButtonName: cancelButtonName)
    }
    
    public func showError(_ content: String, withTitle title: String = errorTitle, withConfirmButtonName confirmButtonName: String = errorConfirmButtonName) {
        hidePreviousMessage()
        messageType = .error
        showMessage(withTitle: title, content: content, confirmButtonName: confirmButtonName, andCancelButtonName: nil)
    }
    
    public func showInput(withTitle title: String, withConfirmButtonName confirmButtonName: String = inputConfirmButtonName, withCancelButtonName cancelButtonName: String = inputCancelButtonName) {
        hidePreviousMessage()
        messageType = .input
        showMessage(withTitle: title, content: nil, confirmButtonName: confirmButtonName, andCancelButtonName: cancelButtonName)
    }
}

/// Constants
private extension CustomizedMessageHelper {
    
    /// Error message.
    static let typeError = "The message type is unknown."
    
    /// The margin of the customized message content.
    static let padding = CGFloat(10)
    
    /// The default background color of the message view.
    static let defaultMessageBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    
    /// The default background color of the mask view.
    static let defaultMaskBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
    
    /// The default background color of the input view.
    static let defaultInputPlaceHolderColor = UIColor(white: 1, alpha: 0.2)
    
    /// The default separator color of the message view.
    static let defaultSeperatorColor = UIColor.white
    
    /// The default text color.
    static let defaultTextColor = UIColor.white
    
    /// The radius of the message box.
    static let radius = CGFloat(5)
    
    /// The width weight of a customized message compared to the window width.
    static let widthWeight = CGFloat(0.7)
    
    /// The maximal height weight of a customized message  compared to the height of the window.
    static let maxHeightWeight = CGFloat(0.6)
}

import AdvancedFoundation
import UIKit
