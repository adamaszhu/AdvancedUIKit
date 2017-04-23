/**
 * DataPicker selects a single value from a set of values.
 * - version: 1.0.0
 * - date: 22/04/2017
 * - author: Adamas
 */
public class DataPicker: UIView {
    
    /**
     * The name of two buttons.
     */
    private let cancelButtonName = "Cancel"
    private let doneButtonName = "Done"
    
    /**
     * The size of the button.
     */
    private let buttonHeight = CGFloat(40)
    private let buttonWidth = CGFloat(80)
    
    /**
     * The delegate of the DataPicker.
     */
    public var dataPickerDelegate: DataPickerDelegate?
    
    /**
     * The title of the picker view.
     */
    public var title: String? {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text
        }
    }
    
    /**
     * The background color of the title.
     */
    public var titleBackgroundColor: UIColor? {
        set {
            titleLabel.backgroundColor = newValue
            doneButton.backgroundColor = newValue
            cancelButton.backgroundColor = newValue
        }
        get {
            return titleLabel.backgroundColor
        }
    }
    
    /**
     * The column list, which is a list of column name and item tuple. Value is the value for each selection. Name is the name of the value which will be displayed on the screen.
     */
    var columns: [DataPickerColumn] {
        didSet {
            pickerView.reloadAllComponents()
        }
    }
    
    /**
     * The picker view.
     */
    private var pickerView: UIPickerView
    
    /**
     * The cancel button.
     */
    private var cancelButton: UIButton
    
    /**
     * The done button.
     */
    private var doneButton: UIButton
    
    /**
     * The title label.
     */
    private var titleLabel: UILabel
    
    /**
     * Initialize the view.
     */
    required public init?(coder aDecoder: NSCoder) {
        cancelButton = UIButton()
        doneButton = UIButton()
        titleLabel = UILabel()
        pickerView = UIPickerView()
        columns = []
//        isVisible = false
//        isInitialized = false
//        titleBackgroundColor = UIColor.grayColor()
        super.init(coder: aDecoder)
        backgroundColor = UIColor.gray
        // COMMENT: Create components in the SinglePicker.
//        let titleColor = UIColor.whiteColor()
//        cancelButton.backgroundColor = titleBackgroundColor
//        cancelButton.setTitle(SinglePickerView.CancelButtonName.localizeInBundle(forClass: self.classForCoder), forState: UIControlState.Normal)
//        cancelButton.addTarget(self, action: #selector(SinglePickerView.cancel), forControlEvents: UIControlEvents.TouchUpInside)
//        doneButton.backgroundColor = titleBackgroundColor
//        doneButton.setTitle(SinglePickerView.DoneButtonName.localizeInBundle(forClass: self.classForCoder), forState: UIControlState.Normal)
//        doneButton.addTarget(self, action: #selector(SinglePickerView.finish), forControlEvents: UIControlEvents.TouchUpInside)
//        titleLabel.backgroundColor = titleBackgroundColor
//        titleLabel.textColor = titleColor
//        titleLabel.textAlignment = NSTextAlignment.Center
//        pickerView.backgroundColor = UIColor.whiteColor()
        //        pickerView.delegate = self
        // COMMENT: The first time to draw the view.
//        originFrame = frame
//        frame = CGRectMake(originFrame!.origin.x, CGFloat(DisplayHelper.screenHeight), originFrame!.size.width, originFrame!.size.height)
        // COMMENT: Set the size and position of each sub element.
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        cancelButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
        cancelButton.backgroundColor = UIColor.green
        titleLabel.frame = CGRect(x: buttonWidth, y: 0, width: frame.width - 2 * buttonWidth, height: buttonHeight)
        titleLabel.backgroundColor = UIColor.blue
        doneButton.frame = CGRect(x: frame.width - buttonWidth, y: 0, width: buttonWidth, height: buttonHeight)
        doneButton.backgroundColor = UIColor.red
        pickerView.frame = CGRect(x: 0, y: buttonHeight, width: frame.width, height: frame.height - buttonHeight)
        addSubview(cancelButton)
        addSubview(doneButton)
        addSubview(pickerView)
        addSubview(titleLabel)
    }
    
}

import UIKit
