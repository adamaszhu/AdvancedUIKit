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
    //
    //    /**
    //     * Error message.
    //     */
    //    private static let ShowError = "It is impossible to show the message."
    //
    //    /**
    //     * The margin of the customized message content.
    //     */
    //    private let MessageMargin: CGFloat = 10
    //
    //    /**
    //     * The width weight of a customized message compared to the window width.
    //     */
    //    private let MessageWidthWeight: CGFloat = 0.7
    //
    //    /**
    //     * The maximal height weight of a customized message  compared to the height of the window.
    //     */
    //    private let MessageHeightWeightMax: CGFloat = 0.6
    //
    //
    /**
     * The delegate of the MessageHelper.
     */
    public var messageHelperDelegate: MessageHelperDelegate?
    //
    //    /**
    //     * Set the visibility of the second button.
    //     */
    //    private var isSecondButtonVisible: Bool {
    //        /**
    //         * - version: 0.0.4
    //         * - date: 19/10/2016
    //         */
    //        didSet {
    //            let firstButtonWidth = isSecondButtonVisible ? frameView.frame.size.width / 2 : frameView.frame.size.width
    //            firstButton.frame = CGRectMake(0, firstButton.frame.origin.y, firstButtonWidth, firstButton.frame.size.height)
    //            secondButton.hidden = !isSecondButtonVisible
    //            buttonSeperatorView.hidden = !isSecondButtonVisible
    //        }
    //    }
    //
    //    /**
    //     * Set the content height.
    //     */
    //    private var contentHeight: CGFloat {
    //        /**
    //         * - version: 0.0.4
    //         * - date: 19/10/2016
    //         */
    //        didSet {
    //            // COMMENT: The max height is 60 percent of the screen height.
    //            let adjustedHeight = contentHeight > rootView.frame.size.height * MessageHeightWeightMax ? rootView.frame.size.height * MessageHeightWeightMax : contentHeight;
    //            contentView.frame = CGRectMake(contentView.frame.origin.x, contentView.frame.origin.y, contentView.frame.width, adjustedHeight + MessageMargin)
    //            buttonView.frame = CGRectMake(buttonView.frame.origin.x, contentView.frame.origin.y + contentView.frame.size.height, buttonView.frame.size.width, buttonView.frame.size.height)
    //            let frameHeight = titleView.frame.size.height + contentView.frame.size.height + buttonView.frame.size.height
    //            frameView.frame = CGRectMake(frameView.frame.origin.x, (rootView.frame.size.height - frameHeight) / 2, frameView.frame.size.width, frameHeight)
    //            backgroundView.frame = CGRectMake(0, 0, frameView.frame.size.width, frameView.frame.size.height)
    //        }
    //    }
    //
    /**
     * The components of a customized view.
     */
    private var frameView: UIView
    private var backgroundView: UIView
    private var titleView: UIView
    private var titleLabel: UILabel
    private var contentView: UIView
    private var messageLabel: UILabel
    private var inputText: UITextField
    private var buttonView: UIView
    private var firstButton: UIButton
    private var secondButton: UIButton
    private var buttonSeperatorView: UIView
    
    /**
     * The type of current message.
     */
    private var messageType: MessageType
    //
    //    /**
    //     * Popup a customized info message.
    //     * - version: 0.0.4
    //     * - date: 19/10/2016
    //     * - parameter title: The title of the message.
    //     * - parameter content: The content of the message.
    //     */
    //    public func showInfo(withTitle title: String = SuccessTitle, withContent content: String) {
    //        hidePreviousMessage()
    //        let localizedConfirmButtonName = CustomizedMessageHelper.InfoConfirmButtonName.localizeInBundle(forClass: self.classForCoder)
    //        let localizedTitle = title == CustomizedMessageHelper.SuccessTitle ? title.localizeInBundle(forClass: self.classForCoder) : title
    //        messageType = MessageType.Info
    //        showMessage(localizedTitle, withContent: content, withConfirmButtonName: localizedConfirmButtonName)
    //    }
    //
    //    /**
    //     * Popup a customized warning message.
    //     * - version: 0.0.4
    //     * - date: 19/10/2016
    //     * - parameter title: The title of the message.
    //     * - parameter content: The content of the message.
    //     */
    //    public func showWarning(withTitle title: String = WarningTitle, withContent content: String) {
    //        hidePreviousMessage()
    //        let localizedConfirmButtonName = CustomizedMessageHelper.WarningConfirmButtonName.localizeInBundle(forClass: self.classForCoder)
    //        let localizedCancelButtonName = CustomizedMessageHelper.WarningCancelButtonName.localizeInBundle(forClass: self.classForCoder)
    //        let localizedTitle = title == CustomizedMessageHelper.WarningTitle ? title.localizeInBundle(forClass: self.classForCoder) : title
    //        messageType = MessageType.Warning
    //        showMessage(localizedTitle, withContent: content, withConfirmButtonName: localizedConfirmButtonName, withCancelButtonName: localizedCancelButtonName)
    //    }
    //
    //    /**
    //     * Popup a customized error message.
    //     * - version: 0.0.4
    //     * - date: 19/10/2016
    //     * - parameter title: The title of the message.
    //     * - parameter content: The content of the message.
    //     */
    //    public func showError(withTitle title: String = ErrorTitle, withContent content: String) {
    //        hidePreviousMessage()
    //        let localizedConfirmButtonName = CustomizedMessageHelper.ErrorConfirmButtonName.localizeInBundle(forClass: self.classForCoder)
    //        let localizedTitle = title == CustomizedMessageHelper.ErrorTitle ? title.localizeInBundle(forClass: self.classForCoder) : title
    //        messageType = MessageType.Error
    //        showMessage(localizedTitle, withContent: content, withConfirmButtonName: localizedConfirmButtonName)
    //    }
    //
    //    /**
    //     * Popup a customized input dialog.
    //     * - version: 0.0.4
    //     * - date: 19/10/2016
    //     * - parameter title: The title of the message.
    //     */
    //    public func showInput(withTitle title: String) {
    //        hidePreviousMessage()
    //        let localizedConfirmButtonName = CustomizedMessageHelper.InputConfirmButtonName.localizeInBundle(forClass: self.classForCoder)
    //        let localizedCancelButtonName = CustomizedMessageHelper.InputCancelButtonName.localizeInBundle(forClass: self.classForCoder)
    //        messageType = MessageType.Input
    //        showMessage(title, withContent: nil, withConfirmButtonName: localizedConfirmButtonName, withCancelButtonName: localizedCancelButtonName, asInputMessage: true)
    //    }
    //
        /**
         * A message has been confirmed.
         */
        public func confirm() {
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
                messageHelperDelegate?.messageHelper(self, didConfirmInput: inputText.text!)
            case .unknown:
                return
                break
            }
            hide()
        }
    //
    //    /**
    //     * Display a customized message.
    //     * - version: 0.0.4
    //     * - date: 19/10/2016
    //     * - parameter title: The title.
    //     * - parameter content: The content of the message.
    //     * - parameter confirmButtonName: The name of the confirm button. If this is nil, the confirm button will not be shown.
    //     * - parameter cancelButtonName: The name of the cancel button.
    //     * - parameter isInput: Whether the message is an input message or not.
    //     * - returns: The alert controller.
    //     */
    //    private func showMessage(title: String, withContent content: String?, withConfirmButtonName confirmButtonName: String,  withCancelButtonName cancelButtonName: String? = nil, asInputMessage isInput: Bool = false) {
    //        titleLabel.text = title
    //        messageLabel.text = content
    //        if cancelButtonName == nil {
    //            isSecondButtonVisible = false
    //        } else {
    //            isSecondButtonVisible = true
    //            secondButton.setTitle(cancelButtonName!, forState: UIControlState.Normal)
    //        }
    //        firstButton.setTitle(confirmButtonName, forState: UIControlState.Normal)
    //        messageLabel.hidden = isInput
    //        inputText.hidden = !isInput
    //        if isInput {
    //            inputText.setDynamicText(" ")
    //            contentHeight = inputText.frame.size.height
    //        } else {
    //            messageLabel.setDynamicText(content)
    //            contentHeight = messageLabel.frame.size.height
    //        }
    //        show()
    //    }
    /**
     * Initialize the object
     */
    public init() {
        frameView = UIView()
        backgroundView = UIView()
        titleView = UIView()
        titleLabel = UILabel()
        contentView = UIView()
        messageLabel = UILabel()
        inputText = UITextField()
        buttonView = UIView()
        firstButton = UIButton()
        secondButton = UIButton()
        buttonSeperatorView = UIView()
        messageType = .unknown
        //        isSecondButtonVisible = false
        //        contentHeight = 0
        super.init()
        //        // COMMENT: Frame view.
        //        frameView.frame = CGRectMake(rootView.frame.size.width * (1 - MessageWidthWeight) / 2, 0, rootView.frame.size.width * MessageWidthWeight, 0)
        //        rootView.addSubview(frameView)
        //        // COMMENT: Background view.
        //        backgroundView.frame = CGRectMake(0, 0, frameView.frame.size.width, frameView.frame.size.height)
        //        backgroundView.backgroundColor = UIColor.blackColor()
        //        backgroundView.alpha = 0.5
        //        backgroundView.layer.cornerRadius = 5;
        //        frameView.addSubview(backgroundView)
        //        // COMMENT: Title label.
        //        titleLabel.setDynamicText(" ")
        //        titleLabel.frame = CGRectMake(MessageMargin, MessageMargin * 2, frameView.frame.size.width - MessageMargin * 2, titleLabel.frame.size.height)
        //        titleLabel.textColor = UIColor.whiteColor()
        //        titleLabel.textAlignment = NSTextAlignment.Center
        //        // COMMENT: Title view.
        //        titleView.frame = CGRectMake(0, 0, frameView.frame.size.width, titleLabel.frame.size.height + MessageMargin * 3)
        //        titleView.addSubview(titleLabel)
        //        frameView.addSubview(titleView)
        //        // COMMENT: Message label.
        //        messageLabel.frame = CGRectMake(MessageMargin, 0, frameView.frame.size.width - MessageMargin * 2, 0)
        //        messageLabel.textColor = UIColor.whiteColor()
        //        messageLabel.textAlignment = NSTextAlignment.Center
        //        frameView.addSubview(messageLabel)
        //        // COMMENT: Input text.
        //        inputText.frame = CGRectMake(MessageMargin, 0, frameView.frame.size.width - MessageMargin * 2, 0)
        //        inputText.textColor = UIColor.whiteColor()
        //        contentView.addSubview(inputText)
        //        // COMMENT: Content view.
        //        contentView.frame = CGRectMake(0, titleView.frame.size.height, frameView.frame.size.width, 0)
        //        contentView.addSubview(messageLabel)
        //        frameView.addSubview(contentView)
        //        // COMMENT: Line view.
        //        let lineView = UIView()
        //        lineView.backgroundColor = UIColor.whiteColor()
        //        lineView.frame = CGRectMake(MessageMargin, 0, frameView.frame.size.width - MessageMargin * 2, 1)
        //        // COMMENT: First button and second button.
        //        firstButton.setDynamicText(" ")
        //        secondButton.setDynamicText(" ")
        //        firstButton.frame = CGRectMake(MessageMargin, lineView.frame.size.height, frameView.frame.size.width / 2 - MessageMargin, firstButton.frame.size.height + MessageMargin * 2)
        //        secondButton.frame = CGRectMake(firstButton.frame.origin.x + firstButton.frame.size.width, lineView.frame.size.height, firstButton.frame.width, firstButton.frame.height)
        //        firstButton.addTarget(self, action: #selector(CustomizedMessageHelper.finish), forControlEvents: UIControlEvents.TouchUpInside)
        //        secondButton.addTarget(self, action: #selector(CustomizedMessageHelper.hide(withAnimation:)), forControlEvents: UIControlEvents.TouchUpInside)
        //        // COMMENT: Button seperate view.
        //        buttonSeperatorView.frame = CGRectMake(secondButton.frame.origin.x, lineView.frame.size.height * 4, 1, secondButton.frame.size.height - lineView.frame.size.height * 6)
        //        buttonSeperatorView.backgroundColor = UIColor.whiteColor()
        //        // COMMENT: Button view.
        //        buttonView.frame = CGRectMake(0, contentView.frame.origin.y, frameView.frame.size.width, lineView.frame.size.height + firstButton.frame.size.height)
        //        buttonView.addSubview(lineView)
        //        buttonView.addSubview(firstButton)
        //        buttonView.addSubview(secondButton)
        //        buttonView.addSubview(buttonSeperatorView)
        //        frameView.addSubview(buttonView)
    }
    
    /**
     * Hide previous message.
     */
    private func hidePreviousMessage() {
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
        return nil
    }
    
}

import UIKit
