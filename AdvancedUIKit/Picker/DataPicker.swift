/// DataPicker selects a single value from a set of values.
///
/// - version: 1.0.0
/// - date: 22/04/2017
/// - author: Adamas
final public class DataPicker: RootView {
    
    /// System error.
    private static let columnError = "The column doesn't exist."
    private static let itemError = "The item doesn't exist."
    
    /// The name of two buttons.
    private static let cancelButtonName = "Cancel"
    private static let doneButtonName = "Done"
    
    /// The duration of the show and hide animation.
    private static let animationDuration = 0.25
    
    /// The size of the button.
    private static let buttonHeight = CGFloat(40)
    private static let buttonWidth = CGFloat(80)
    
    /// The delegate of the DataPicker.
    public var dataPickerDelegate: DataPickerDelegate?
    
    /// The title of the picker view.
    public var title: String? {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text
        }
    }
    
    /// The background color of the title.
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
    
    /// The column list, which is a list of column name and item tuple. Value is the value for each selection. Name is the name of the value which will be displayed on the screen.
    public private(set) var columns: [DataPickerColumn] {
        didSet {
            pickerView.reloadAllComponents()
        }
    }
    
    /// The picker view.
    private var pickerView: UIPickerView
    
    /// The cancel button.
    private var cancelButton: UIButton
    
    /// The done button.
    private var doneButton: UIButton
    
    /// The title label.
    private var titleLabel: UILabel
    
    /// Set the DataPicker with a single column.
    ///
    /// - Parameter items: The item list.
    public func setSingleColumn(_ items: [DataPickerItem]) {
        columns = [DataPickerColumn(items: items)]
    }
    
    // TODO: Set picker with multiple columns
    
    /// Select an item.
    ///
    /// - Parameters:
    ///   - value: The value to be selected.
    ///   - index: The index of the column.
    public func selectValue(_ value: String, atColumn index: Int = 0) {
        guard 0 ..< columns.count ~= index else {
            Logger.standard.log(error: DataPicker.columnError)
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
        Logger.standard.log(error: DataPicker.itemError)
    }
    
    /// The selected values are confirmed by clicking the done button.
    func confirmSelection() {
        var selections = [String]()
        for index in 0 ..< columns.count {
            selections.append(columns[index].items[pickerView.selectedRow(inComponent: index)].value)
        }
        dataPickerDelegate?.dataPicker(dataPicker: self, didSelectValue: selections)
        // Waiting for the view to be refreshed for a button text change.
        perform(#selector(hide), with: nil, afterDelay: 0.2)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        cancelButton = .init()
        doneButton = .init()
        titleLabel = .init()
        pickerView = .init()
        columns = []
        super.init(coder: aDecoder)
    }
    
    public override func hide() {
        guard isVisible else {
            Logger.standard.log(warning: DataPicker.hidingWarning)
            return
        }
        animate(withChange: { [unowned self] _ in
            self.frame = .init(x: self.originalFrame.origin.x, y: self.originalFrame.origin.y + self.originalFrame.height, width: self.originalFrame.width, height: self.originalFrame.height)
        }, withPreparation: { [unowned self] _ in
            self.frame = self.originalFrame
        }) {
            super.hide()
        }
    }
    
    public override func show() {
        guard !isVisible else {
            Logger.standard.log(warning: DataPicker.showingWarning)
            return
        }
        animate(withChange: { [unowned self] _ in
            self.frame = self.originalFrame
        }, withPreparation: { [unowned self] _ in
            self.frame = .init(x: self.originalFrame.origin.x, y: self.originalFrame.origin.y + self.originalFrame.height, width: self.originalFrame.width, height: self.originalFrame.height)
        }) {
            super.show()
        }
    }
    
    public override func initialize() {
        titleBackgroundColor = .gray
        let titleTextColor = UIColor.white
        cancelButton.backgroundColor = titleBackgroundColor
        cancelButton.setTitle(DataPicker.cancelButtonName.localizedInternalString(forType: self), for: .normal)
        cancelButton.addTarget(self, action: #selector(hide), for: .touchUpInside)
        doneButton.backgroundColor = titleBackgroundColor
        doneButton.setTitle(DataPicker.doneButtonName.localizedInternalString(forType: self), for: .normal)
        doneButton.addTarget(self, action: #selector(confirmSelection), for: .touchUpInside)
        titleLabel.backgroundColor = titleBackgroundColor
        titleLabel.textColor = titleTextColor
        titleLabel.textAlignment = .center
        addSubview(cancelButton)
        addSubview(doneButton)
        addSubview(pickerView)
        addSubview(titleLabel)
        pickerView.backgroundColor = .white
        pickerView.delegate = self
    }
    
    public override func render() {
        cancelButton.frame = .init(x: 0, y: 0, width: DataPicker.buttonWidth, height: DataPicker.buttonHeight)
        titleLabel.frame = .init(x: DataPicker.buttonWidth, y: 0, width: frame.width - 2 * DataPicker.buttonWidth, height: DataPicker.buttonHeight)
        doneButton.frame = .init(x: frame.width - DataPicker.buttonWidth, y: 0, width: DataPicker.buttonWidth, height: DataPicker.buttonHeight)
        pickerView.frame = .init(x: 0, y: DataPicker.buttonHeight, width: frame.width, height: frame.height - DataPicker.buttonHeight)
        frame = .init(x: originalFrame.origin.x, y: originalFrame.origin.y + originalFrame.height, width: originalFrame.width, height: originalFrame.height)
        super.hide()
    }
    
}

import UIKit
