/// DataPicker selects a single value from a set of values.
///
/// - version: 1.5.0
/// - date: 22/05/2019
/// - author: Adamas
final public class DataPicker: RootView {
    
    /// The delegate of the DataPicker.
    public weak var delegate: DataPickerDelegate?
    
    /// The title of the picker view.
    public var title: String? {
        set { titleLabel.text = newValue }
        get { titleLabel.text }
    }
    
    /// The background color of the title.
    public var titleBackgroundColor: UIColor? {
        set {
            titleLabel.backgroundColor = newValue
            doneButton.backgroundColor = newValue
            cancelButton.backgroundColor = newValue
        }
        get {
            titleLabel.backgroundColor
        }
    }
    
    /// The column list, which is a list of column name and item tuple. Value is the value for each selection. Name is the name of the value which will be displayed on the screen.
    public private (set) var columns: [DataPickerColumn] = [] {
        didSet {
            pickerView.reloadAllComponents()
        }
    }
    
    /// The distance that the controller should be pushed up.
    private var pushDistance: CGFloat {
        guard let trigger = trigger, let superview = superview, let triggerOriginalFrame = triggerOriginalFrame else {
            return 0
        }
        let triggerFrame = superview.convert(triggerOriginalFrame, from: trigger.superview)
        if triggerFrame.origin.y + triggerFrame.height + frame.size.height > superview.frame.size.height {
            return superview.frame.size.height - triggerFrame.origin.y - triggerFrame.height - frame.size.height
        } else {
            return 0
        }
    }
    
    /// The view that is used to control the picker.
    public var trigger: UIView? {
        didSet { triggerOriginalFrame = nil }
    }
    
    /// The original frame of the controller.
    private var triggerOriginalFrame: CGRect?
    
    /// The picker view.
    private var pickerView: UIPickerView = UIPickerView()
    
    /// The cancel button.
    private var cancelButton: UIButton = UIButton()
    
    /// The done button.
    private var doneButton: UIButton = UIButton()
    
    /// The title label.
    private var titleLabel: UILabel = UILabel()
    
    /// Set the DataPicker with a single column.
    ///
    /// - Parameter items: The item list.
    public func set(_ items: [DataPickerItem]) {
        columns = [DataPickerColumn(items: items)]
    }
    
    /// Set the DataPicker with columns.
    ///
    /// - Parameter columns: The column list.
    public func set(_ columns: [DataPickerColumn]) {
        self.columns = columns
    }
    
    /// Select an item.
    ///
    /// - Parameters:
    ///   - value: The value to be selected.
    ///   - index: The index of the column.
    public func selectValue(_ value: String, atColumn index: Int = 0) {
        guard 0 ..< columns.count ~= index else {
            Logger.standard.logError(Self.columnError)
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
        Logger.standard.logError(Self.itemError)
    }
    
    /// The selected values are confirmed by clicking the done button.
    @objc func confirmSelection() {
        var selections = [String]()
        for index in 0 ..< columns.count {
            selections.append(columns[index].items[pickerView.selectedRow(inComponent: index)].value)
        }
        hide()
        DispatchQueue.main.asyncAfter(deadline: .now() + Self.animationDuration) { [weak self]  in
            guard let self = self else {
                return
            }
            // Wait for finishing the hide animation
            self.delegate?.dataPicker(self, didSelectValue: selections)
        }
    }
    
    @objc public override func hide() {
        guard isVisible else {
            Logger.standard.logWarning(Self.hidingWarning)
            return
        }
        animateChange({ [weak self] in
            guard let self = self else {
                return
            }
            self.frame.origin = CGPoint(x: self.originalFrame.origin.x, y: self.originalFrame.origin.y + self.originalFrame.height)
            // Push down the controller
            if let controllerOriginalFrame = self.triggerOriginalFrame {
                self.trigger?.frame = controllerOriginalFrame
            }
            }, withDuration: Self.animationDuration,
               preparation: { [weak self] in
                guard let self = self else {
                    return
                }
                self.frame = self.originalFrame
        }) {
            super.hide()
            self.isHidden = true
        }
    }
    
    public override func show() {
        guard !isVisible else {
            Logger.standard.logWarning(Self.showingWarning)
            return
        }
        if triggerOriginalFrame == nil {
            triggerOriginalFrame = trigger?.frame
        }
        let pushDistance = self.pushDistance - 1
        animateChange({ [weak self] in
            guard let self = self else {
                return
            }
            // Push up the controller
            if let triggerOrigin = self.triggerOriginalFrame?.origin {
                self.trigger?.frame.origin = CGPoint(x: triggerOrigin.x, y: triggerOrigin.y + pushDistance)
            }
            self.frame = self.originalFrame
            }, withDuration: Self.animationDuration,
               preparation: { [weak self] in
                guard let self = self else {
                    return
                }
                self.frame.origin = CGPoint(x: self.originalFrame.origin.x, y: self.originalFrame.origin.y + self.originalFrame.height)
                self.isHidden = false
        }) {
            super.show()
        }
    }
    
    public override func initialize() {
        titleBackgroundColor = .gray
        let titleTextColor = UIColor.white
        cancelButton.backgroundColor = titleBackgroundColor
        cancelButton.setTitle(Self.cancelButtonName.localizedInternalString(forType: Self.self), for: .normal)
        cancelButton.addTarget(self, action: #selector(hide), for: .touchUpInside)
        doneButton.backgroundColor = titleBackgroundColor
        doneButton.setTitle(Self.doneButtonName.localizedInternalString(forType: Self.self), for: .normal)
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
        cancelButton.frame = CGRect(x: 0, y: 0, width: Self.buttonWidth, height: Self.buttonHeight)
        titleLabel.frame = CGRect(x: Self.buttonWidth, y: 0, width: frame.width - 2 * Self.buttonWidth, height: Self.buttonHeight)
        doneButton.frame = CGRect(x: frame.width - Self.buttonWidth, y: 0, width: Self.buttonWidth, height: Self.buttonHeight)
        pickerView.frame = CGRect(x: 0, y: Self.buttonHeight, width: frame.width, height: frame.height - Self.buttonHeight)
        frame = CGRect(x: originalFrame.origin.x, y: originalFrame.origin.y + originalFrame.height, width: originalFrame.width, height: originalFrame.height)
        super.hide()
    }
}

/// UIPickerViewDelegate
extension DataPicker: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label: UILabel
        if let reusableLabel = view as? UILabel {
            label = reusableLabel
        } else {
            label = UILabel()
            label.textAlignment = .center
            label.textColor = .black
        }
        label.text = columns[component].items[row].name
        return label
    }
}

/// UIPickerViewDataSource
extension DataPicker: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        columns.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        columns[component].items.count
    }
}

/// Constants
private extension DataPicker {
    
    /// System error.
    static let columnError = "The column doesn't exist."
    static let itemError = "The item doesn't exist."
    
    /// The name of two buttons.
    static let cancelButtonName = "Cancel"
    static let doneButtonName = "Done"
    
    /// The duration of the show and hide animation.
    static let animationDuration = 0.25
    
    /// The size of the button.
    static let buttonHeight = CGFloat(40)
    static let buttonWidth = CGFloat(80)
}

import AdvancedFoundation
import UIKit
