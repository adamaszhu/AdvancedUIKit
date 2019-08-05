/// DataPicker selects a single value from a set of values.
///
/// - version: 1.0.0
/// - date: 22/04/2017
/// - author: Adamas
final public class DataPicker: RootView {
    
    /// The delegate of the DataPicker.
    public var dataPickerDelegate: DataPickerDelegate?
    
    /// The title of the picker view.
    @objc public var title: String? {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text
        }
    }
    
    /// The background color of the title.
    @objc public var titleBackgroundColor: UIColor? {
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
    
    /// The distance that the controller should be pushed up.
    private var pushDistance: CGFloat {
        guard let controller = controller, let superview = superview else {
            return 0
        }
        let controllerFrame = superview.convert(controller.frame, from: controller.superview)
        return controllerFrame.origin.y + controllerFrame.height - self.frame.origin.y - self.frame.height
    }
    
    /// The view that is used to control the picker.
    @objc public var controller: UIView?
    
    /// The original frame of the controller.
    private var controllerOriginalFrame: CGRect?
    
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
    
    /// Select an item.
    ///
    /// - Parameters:
    ///   - value: The value to be selected.
    ///   - index: The index of the column.
    @objc public func selectValue(_ value: String, atColumn index: Int = 0) {
        guard 0 ..< columns.count ~= index else {
            Logger.standard.logError(DataPicker.columnError)
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
        Logger.standard.logError(DataPicker.itemError)
    }
    
    /// The selected values are confirmed by clicking the done button.
    @objc func confirmSelection() {
        var selections = [String]()
        for index in 0 ..< columns.count {
            selections.append(columns[index].items[pickerView.selectedRow(inComponent: index)].value)
        }
        hide()
        DispatchQueue.main.asyncAfter(deadline: .now() + DataPicker.animationDuration) { [unowned self]  in
            // Wait for finishing the hide animation
            self.dataPickerDelegate?.dataPicker(dataPicker: self, didSelectValue: selections)
        }
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
            Logger.standard.logWarning(DataPicker.hidingWarning)
            return
        }
        animateChange({ [unowned self] in
            self.frame.origin = .init(x: self.originalFrame.origin.x, y: self.originalFrame.origin.y + self.originalFrame.height)
            // Push down the controller
            if let controllerOriginalFrame = self.controllerOriginalFrame {
                self.controller?.frame = controllerOriginalFrame
            }
            }, withDuration: DataPicker.animationDuration, withPreparation: { [unowned self] in
                self.frame = self.originalFrame
        }) {
            super.hide()
            self.isHidden = true
        }
    }
    
    public override func show() {
        guard !isVisible else {
            Logger.standard.logWarning(DataPicker.showingWarning)
            return
        }
        controllerOriginalFrame = controller?.frame
        let pushDistance = self.pushDistance - 1
        animateChange({ [unowned self] in
            // Push up the controller
            if let controllerOrigin = self.controllerOriginalFrame?.origin {
                self.controller?.frame.origin = .init(x: controllerOrigin.x, y: controllerOrigin.y + pushDistance)
            }
            self.frame = self.originalFrame
            }, withDuration: DataPicker.animationDuration, withPreparation: { [unowned self] in
                self.frame.origin = .init(x: self.originalFrame.origin.x, y: self.originalFrame.origin.y + self.originalFrame.height)
                self.isHidden = false
        }) {
            super.show()
        }
    }
    
    public override func initialize() {
        titleBackgroundColor = .gray
        let titleTextColor = UIColor.white
        cancelButton.backgroundColor = titleBackgroundColor
        cancelButton.setTitle(DataPicker.cancelButtonName.localizedInternalString(forType: DataPicker.self), for: .normal)
        cancelButton.addTarget(self, action: #selector(hide), for: .touchUpInside)
        doneButton.backgroundColor = titleBackgroundColor
        doneButton.setTitle(DataPicker.doneButtonName.localizedInternalString(forType: DataPicker.self), for: .normal)
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

import AdvancedFoundation
import UIKit
