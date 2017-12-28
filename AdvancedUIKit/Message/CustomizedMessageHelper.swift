/// CustomizedMessageHelper is used to display a customized message on the screen.
///
/// - author: Adamas
/// - version: 1.0.3
/// - date: 30/05/2017
final public class CustomizedMessageHelper: PopupView {
    
    /// Get the shared instance of the CustomizedMessageHelper. If the protocol will be implemented, please create a new object.
    @objc public static let standard = CustomizedMessageHelper()
    
    /// The mask color.
    @objc public var maskColor: UIColor? {
        set {
            backgroundColor = newValue
        }
        get {
            return backgroundColor
        }
    }
    
    /// The background color of the message frame.
    @objc public var frameColor: UIColor? {
        set {
            frameView.backgroundColor = newValue
        }
        get {
            return frameView.backgroundColor
        }
    }
    
    /// The type of current message.
    var messageType: MessageType
    
    /// The visibility of the second button.
    private var isCancelButtonVisible: Bool {
        set {
            let confirmButtonWidth = newValue ? buttonView.frame.width / 2 : buttonView.frame.width
            confirmButton.frame = .init(x: buttonView.frame.width - confirmButtonWidth, y: confirmButton.frame.origin.y, width: confirmButtonWidth, height: confirmButton.frame.height)
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
            titleLabel.frame.size = .init(width: titleLabel.frame.width, height: titleLabel.actualHeight)
            let titleViewY = title == nil ? CustomizedMessageHelper.padding : CustomizedMessageHelper.padding * 2
            titleView.frame = .init(x: titleView.frame.origin.x, y: titleViewY, width: titleView.frame.width, height: titleLabel.frame.height)
        }
        get {
            return titleLabel.text
        }
    }
    
    /// The content height.
    private var contentHeight: CGFloat {
        set {
            let contentViewY = titleView.frame.height + titleView.frame.origin.y + CustomizedMessageHelper.padding
            contentView.frame = .init(x: contentView.frame.origin.x ,y: contentViewY, width: contentView.frame.width, height: newValue)
            let buttonViewY = contentViewY + contentView.frame.height + CustomizedMessageHelper.padding * 1.5
            buttonView.frame.origin = .init(x: buttonView.frame.origin.x, y: buttonViewY)
            let frameHeight = buttonViewY + buttonView.frame.height
            frameView.frame = .init(x: frameView.frame.origin.x, y: (frame.height - frameHeight) / 2, width: frameView.frame.width, height: frameHeight)
        }
        get {
            return contentView.frame.height - CustomizedMessageHelper.padding * 2
        }
    }
    
    /// The components of a customized view.
    private var frameView: UIView
    private var titleView: UIView
    private var titleLabel: UILabel
    private var contentView: UIView
    private var messageLabel: UILabel
    private var inputText: UITextField
    private var buttonView: UIView
    private var cancelButton: UIButton
    private var confirmButton: UIButton
    private var buttonSeperatorView: UIView
    
    /// MessageHelper
    public var messageHelperDelegate: MessageHelperDelegate?
    
    /// Display a customized message.
    ///
    /// - Parameters:
    ///   - title: The title.
    ///   - content: The content of the message. If it is nil, then it will be an input message
    ///   - confirmButtonName: The name of the confirm button. If this is nil, the confirm button will not be shown.
    ///   - cancelButtonName: The name of the cancel button.
    @objc func showMessage(withTitle title: String, withContent content: String?, withConfirmButtonName confirmButtonName: String,  withCancelButtonName cancelButtonName: String? = nil) {
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
    @objc public init() {
        frameView = .init()
        titleView = .init()
        titleLabel = .init()
        contentView = .init()
        messageLabel = .init()
        inputText = .init()
        buttonView = .init()
        cancelButton = .init()
        confirmButton = .init()
        buttonSeperatorView = .init()
        messageType = .unknown
        super.init()
        backgroundColor = CustomizedMessageHelper.defaultMaskBackgroundColor
        let contentWidth = frame.width * CustomizedMessageHelper.widthWeight - CustomizedMessageHelper.padding * 2
        // The height of messageLabel, contentView
        // The y location of messageView and buttonView will be settled dynamically later.
        // Frame view. The height and Y will be changed later.
        frameView.frame = .init(x: frame.width * (1 - CustomizedMessageHelper.widthWeight) / 2, y: 0, width: frame.width * CustomizedMessageHelper.widthWeight, height: 0)
        frameView.backgroundColor = CustomizedMessageHelper.defaultMessageBackgroundColor
        frameView.layer.cornerRadius = CustomizedMessageHelper.radius
        addSubview(frameView)
        // Title label. The height will be changed later.
        titleLabel.frame = .init(x: 0, y: 0, width: contentWidth, height: 0)
        titleLabel.textColor = CustomizedMessageHelper.defaultTextColor
        titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize)
        titleLabel.textAlignment = .center
        titleView.addSubview(titleLabel)
        // Title view. The height and Y will be changed later.
        titleView.frame = .init(x: CustomizedMessageHelper.padding, y: 0, width: contentWidth, height: 0)
        frameView.addSubview(titleView)
        // Message label. The height will be changed later.
        messageLabel.frame = .init(x: 0, y: 0, width: contentWidth, height: 0)
        messageLabel.textColor = CustomizedMessageHelper.defaultTextColor
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        contentView.addSubview(messageLabel)
        // Input text.
        inputText.frame = .init(x: 0, y: 0, width: contentWidth, height: inputText.lineHeight)
        inputText.textColor = CustomizedMessageHelper.defaultTextColor
        inputText.tintColor = CustomizedMessageHelper.defaultTextColor
        inputText.textAlignment = .center
        contentView.addSubview(inputText)
        // Content view. The height and Y will be changed later.
        contentView.frame = .init(x: CustomizedMessageHelper.padding, y: 0, width: contentWidth, height: 0)
        frameView.addSubview(contentView)
        // Line view.
        let lineView = UIView()
        lineView.backgroundColor = CustomizedMessageHelper.defaultSeperatorColor
        lineView.frame = .init(x: CustomizedMessageHelper.padding, y: 0, width: contentWidth, height: 1)
        buttonView.addSubview(lineView)
        // First button and second button.
        cancelButton.title = .empty
        cancelButton.frame = .init(x: 0, y: lineView.frame.size.height, width: frameView.frame.width / 2, height: cancelButton.lineHeight + CustomizedMessageHelper.padding * 2)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        buttonView.addSubview(cancelButton)
        confirmButton.title = .empty
        confirmButton.frame = .init(x: cancelButton.frame.width, y: lineView.frame.height, width: cancelButton.frame.width, height: cancelButton.frame.height)
        confirmButton.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        buttonView.addSubview(confirmButton)
        // Button seperate view.
        buttonSeperatorView.frame = .init(x: confirmButton.frame.origin.x, y: lineView.frame.size.height + CustomizedMessageHelper.padding / 2, width: 1, height: confirmButton.frame.height - CustomizedMessageHelper.padding)
        buttonSeperatorView.backgroundColor = CustomizedMessageHelper.defaultSeperatorColor
        buttonView.addSubview(buttonSeperatorView)
        // Button view. The Y will be changed later.
        buttonView.frame = .init(x: 0, y: 0, width: frameView.frame.width, height: lineView.frame.size.height + confirmButton.frame.size.height)
        frameView.addSubview(buttonView)
    }
    
    /// A message has been confirmed.
    @objc func confirm() {
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
            Logger.standard.log(error: CustomizedMessageHelper.typeError)
            break
        }
        hide()
    }
    
    /// A message has been cancelled.
    @objc func cancel() {
        switch messageType {
        case .info:
            break
        case .warning:
            messageHelperDelegate?.messageHelperDidCancelWarning(self)
            break
        case .error:
            break
        case .input:
            messageHelperDelegate?.messageHelperDidCancelInput(self)
            inputText.text = .empty
            break
        case .unknown:
            Logger.standard.log(error: CustomizedMessageHelper.typeError)
            break
        }
        hide()
    }
    
    /// Hide previous message.
    @objc func hidePreviousMessage() {
        guard messageType != .unknown else {
            Logger.standard.log(error: CustomizedMessageHelper.typeError)
            return
        }
        messageType = .unknown
        hide()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        Logger.standard.log(error: CustomizedMessageHelper.initError)
        return nil
    }
    
}

import UIKit
