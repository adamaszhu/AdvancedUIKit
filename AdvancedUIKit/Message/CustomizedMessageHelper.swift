/**
 * CustomizedMessageHelper is used to display a customized message on the screen.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 30/05/2017
 */
public class CustomizedMessageHelper: PopupView {
    
    /**
     * Get the shared instance of the CustomizedMessageHelper. If the protocol will be implemented, please create a new object.
     */
    public static let standard: CustomizedMessageHelper = CustomizedMessageHelper()
    
    /**
     * Error message.
     */
    private let typeError = "The message type is unknown."
    private let initError = "Constructor init(coder) shouldn't be called."
    
    /**
     * The margin of the customized message content.
     */
    private let padding = CGFloat(10)
    
    /**
     * The default background color of the message view.
     */
    private let defaultBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    
    /**
     * The default background color of the mask view.
     */
    private let defaultMaskBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    
    /**
     * The default separator color of the message view.
     */
    private let defaultSeperatorColor = UIColor.white
    
    /**
     * The default text color.
     */
    private let defaultTextColor = UIColor.white
    
    /**
     * The radius of the message box.
     */
    private let radius = CGFloat(5)
    
    /**
     * The width weight of a customized message compared to the window width.
     */
    private let widthWeight = CGFloat(0.7)
    
    /**
     * The maximal height weight of a customized message  compared to the height of the window.
     */
    private let maxHeightWeight = CGFloat(0.6)
    
    /**
     * The type of current message.
     */
    var messageType: MessageType
    
    /**
     * The visibility of the second button.
     */
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
    
    /**
     * The title of the message.
     */
    private var title: String? {
        set {
            titleLabel.text = title
            titleLabel.frame.size = CGSize(width: titleLabel.frame.width, height: titleLabel.actualHeight)
            titleView.frame.size = CGSize(width: titleView.frame.width, height: titleLabel.frame.height + padding * 2)
            contentView.frame.origin = CGPoint(x: 0, y: titleView.frame.height)
        }
        get {
            return titleLabel.text
        }
    }
    
    /**
     * The content height.
     */
    private var contentHeight: CGFloat {
        set {
            let adjustedHeight = contentHeight > frame.height * maxHeightWeight ? frame.height * maxHeightWeight : newValue
            contentView.frame.size = CGSize(width: contentView.frame.width, height: adjustedHeight + padding)
            buttonView.frame.origin = CGPoint(x: buttonView.frame.origin.x, y: contentView.frame.origin.y + contentView.frame.height)
            let frameHeight = titleView.frame.height + contentView.frame.height + buttonView.frame.height
            frameView.frame = CGRect(x: frameView.frame.origin.x, y: (frame.height - frameHeight) / 2, width: frameView.frame.width, height: frameHeight)
        }
        get {
            return contentView.frame.height - padding
        }
    }
    
    /**
     * The components of a customized view.
     */
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
    
    /**
     * MessageHelper
     */
    public var messageHelperDelegate: MessageHelperDelegate?
    
    /**
     * Display a customized message.
     * - parameter title: The title.
     * - parameter content: The content of the message. If it is nil, then it will be an input message
     * - parameter confirmButtonName: The name of the confirm button. If this is nil, the confirm button will not be shown.
     * - parameter cancelButtonName: The name of the cancel button.
     */
    func showMessage(withTitle title: String, withContent content: String?, withConfirmButtonName confirmButtonName: String,  withCancelButtonName cancelButtonName: String? = nil) {
        self.title = title
        messageLabel.text = content
        confirmButton.title = confirmButtonName
        let isInput = content == nil
        messageLabel.isHidden = isInput
        inputText.isHidden = !isInput
        if isInput {
            contentHeight = inputText.frame.height
        } else {
            messageLabel.text = content
            messageLabel.frame.size = CGSize(width: messageLabel.frame.width, height: messageLabel.actualHeight)
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
    
    /**
     * Initialize the object
     */
    public init() {
        frameView = UIView()
        titleView = UIView()
        titleLabel = UILabel()
        contentView = UIView()
        messageLabel = UILabel()
        inputText = UITextField()
        buttonView = UIView()
        cancelButton = UIButton()
        confirmButton = UIButton()
        buttonSeperatorView = UIView()
        messageType = .unknown
        super.init()
        backgroundColor = defaultMaskBackgroundColor
        let contentWidth = frame.width * widthWeight - padding * 2
        // COMMENT: The height of titleLabel, titleView, messageLabel, contentView and frameView will be settled dynamically later.
        // COMMENT: Frame view.
        frameView.frame = CGRect(x: frame.width * (1 - widthWeight) / 2, y: 0, width: frame.width * widthWeight, height: 0)
        frameView.backgroundColor = defaultBackgroundColor
        frameView.layer.cornerRadius = radius
        addSubview(frameView)
        // COMMENT: Title label.
        titleLabel.frame = CGRect(x: padding, y: padding * 2, width: contentWidth, height: 0)
        titleLabel.textColor = defaultTextColor
        titleLabel.textAlignment = .center
        titleView.addSubview(titleLabel)
        // COMMENT: Title view.
        titleView.frame = CGRect(x: 0, y: 0, width: frameView.frame.width, height: 0)
        frameView.addSubview(titleView)
        // COMMENT: Message label.
        messageLabel.frame = CGRect(x: padding, y: 0, width: contentWidth, height: 0)
        messageLabel.textColor = defaultTextColor
        messageLabel.textAlignment = .center
        contentView.addSubview(messageLabel)
        // COMMENT: Input text.
        inputText.frame = CGRect(x: padding, y: 0, width: contentWidth, height: inputText.lineHeight)
        inputText.textColor = defaultTextColor
        contentView.addSubview(inputText)
        // COMMENT: Content view.
        contentView.frame = CGRect(x: 0, y: titleView.frame.height, width: frameView.frame.width, height: 0)
        frameView.addSubview(contentView)
        // COMMENT: Line view.
        let lineView = UIView()
        lineView.backgroundColor = defaultSeperatorColor
        lineView.frame = CGRect(x: padding, y: 0, width: contentWidth, height: 1)
        buttonView.addSubview(lineView)
        // COMMENT: First button and second button.
        cancelButton.title = ""
        cancelButton.frame = CGRect(x: 0, y: lineView.frame.size.height, width: frameView.frame.width / 2, height: cancelButton.lineHeight + padding * 2)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        buttonView.addSubview(cancelButton)
        confirmButton.title = ""
        confirmButton.frame = CGRect(x: cancelButton.frame.width, y: lineView.frame.height, width: cancelButton.frame.width, height: cancelButton.frame.height)
        confirmButton.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        buttonView.addSubview(confirmButton)
        // COMMENT: Button seperate view.
        buttonSeperatorView.frame = CGRect(x: confirmButton.frame.origin.x, y: lineView.frame.size.height + padding, width: 1, height: confirmButton.frame.height - padding * 2)
        buttonSeperatorView.backgroundColor = defaultSeperatorColor
        buttonView.addSubview(buttonSeperatorView)
        // COMMENT: Button view.
        buttonView.frame = CGRect(x: 0, y: contentView.frame.origin.y, width: frameView.frame.width, height: lineView.frame.size.height + confirmButton.frame.size.height)
        frameView.addSubview(buttonView)
    }
    
    /**
     * A message has been confirmed.
     */
    func confirm() {
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
            messageHelperDelegate?.messageHelper(self, didConfirmInput: inputText.text ?? "")
            break
        case .unknown:
            Logger.standard.logError(typeError)
            break
        }
        hide()
    }
    
    /**
     * A message has been cancelled.
     */
    func cancel() {
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
            break
        case .unknown:
            Logger.standard.logError(typeError)
            break
        }
        hide()
    }
    
    /**
     * Hide previous message.
     */
    func hidePreviousMessage() {
        guard messageType != .unknown else {
            return
        }
        messageType = .unknown
        hide()
    }
    
    /**
     * UIView
     */
    public required init?(coder aDecoder: NSCoder) {
        Logger.standard.logError(initError)
        return nil
    }
    
}

import UIKit
