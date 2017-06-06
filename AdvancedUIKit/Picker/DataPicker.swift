/**
 * DataPicker selects a single value from a set of values.
 * - version: 1.0.0
 * - date: 22/04/2017
 * - author: Adamas
 */
public class DataPicker: RootView {
    
    /**
     * System error.
     */
    private let columnError = "The column doesn't exist."
    private let itemError = "The item doesn't exist."
    
    /**
     * The name of two buttons.
     */
    private let cancelButtonName = "Cancel"
    private let doneButtonName = "Done"
    
    /**
     * The duration of the show and hide animation.
     */
    private let animationDuration = 0.25
    
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
    public private(set) var columns: Array<DataPickerColumn> {
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
        super.init(coder: aDecoder)
    }
    
    /**
     * Set the DataPicker with a single column.
     * - parameter items: The item list.
     */
    public func setSingleColumn(_ items: Array<DataPickerItem>) {
        columns = [DataPickerColumn(items: items)]
    }
    
    // TODO: Set picker with multiple columns
    
    /**
     * Select an item.
     * - parameter value: The value to be selected.
     * - parameter index: The index of the column.
     */
    public func selectValue(_ value: String, atColumn index: Int = 0) {
        guard (index >= 0) && (index < columns.count) else {
            Logger.standard.logError(columnError)
            return
        }
        var item: DataPickerItem
        for itemIndex in 0 ..< columns[index].items.count {
            item = columns[index].items[itemIndex]
            if item.value == value {
                pickerView.selectRow(itemIndex, inComponent: index, animated: false)
                return
            }
        }
        Logger.standard.logError(itemError)
    }
    
    /**
     * The selected values are confirmed by clicking the done button.
     */
    func confirmSelection() {
        var selections = Array<String>()
        for index in 0 ..< columns.count {
            selections.append(columns[index].items[pickerView.selectedRow(inComponent: index)].value)
        }
        dataPickerDelegate?.dataPicker(dataPicker: self, didSelectValue: selections)
        // COMMENT: Waiting for the view to be refreshed for a button text change.
        perform(#selector(hide), with: nil, afterDelay: 0.2)
    }
    
    /**
     * RouteViewVisible
     */
    public override func hide() {
        if !isVisible {
            return
        }
        animate(withChange: { [unowned self] _ in
            self.frame = CGRect(x: self.originalFrame.origin.x, y: self.originalFrame.origin.y + self.originalFrame.height, width: self.originalFrame.width, height: self.originalFrame.height)
        }, withPreparation: { [unowned self] _ in
            self.frame = self.originalFrame
        }) {
            super.hide()
        }
    }
    
    /**
     * RouteViewVisible
     */
    public override func show() {
        if isVisible {
            return
        }
        animate(withChange: { [unowned self] _ in
            self.frame = self.originalFrame
        }, withPreparation: { [unowned self] _ in
            self.frame = CGRect(x: self.originalFrame.origin.x, y: self.originalFrame.origin.y + self.originalFrame.height, width: self.originalFrame.width, height: self.originalFrame.height)
        }) {
            super.show()
        }
    }
    
    /**
     * RouteViewInitializable
     */
    public override func initialize() {
        titleBackgroundColor = UIColor.gray
        let titleTextColor = UIColor.white
        cancelButton.backgroundColor = titleBackgroundColor
        cancelButton.setTitle(cancelButtonName.localizeWithinFramework(forType: self), for: .normal)
        cancelButton.addTarget(self, action: #selector(hide), for: .touchUpInside)
        doneButton.backgroundColor = titleBackgroundColor
        doneButton.setTitle(doneButtonName.localizeWithinFramework(forType: self), for: .normal)
        doneButton.addTarget(self, action: #selector(confirmSelection), for: .touchUpInside)
        titleLabel.backgroundColor = titleBackgroundColor
        titleLabel.textColor = titleTextColor
        titleLabel.textAlignment = .center
        addSubview(cancelButton)
        addSubview(doneButton)
        addSubview(pickerView)
        addSubview(titleLabel)
        pickerView.backgroundColor = UIColor.white
        pickerView.delegate = self
    }
    
    /**
     * RouteViewInitializable
     */
    public override func render() {
        cancelButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
        titleLabel.frame = CGRect(x: buttonWidth, y: 0, width: frame.width - 2 * buttonWidth, height: buttonHeight)
        doneButton.frame = CGRect(x: frame.width - buttonWidth, y: 0, width: buttonWidth, height: buttonHeight)
        pickerView.frame = CGRect(x: 0, y: buttonHeight, width: frame.width, height: frame.height - buttonHeight)
        frame = CGRect(x: originalFrame.origin.x, y: originalFrame.origin.y + originalFrame.height, width: originalFrame.width, height: originalFrame.height)
        super.hide()
    }
    
}

import UIKit
