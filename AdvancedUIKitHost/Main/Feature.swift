enum Feature: String {
    
    case device = "Device"
    case label = "Label"
    case picker = "Picker"
    
    var viewControllerID: String {
        switch self {
        case .device:
            return String(describing: DeviceViewController.self)
        case .label:
            return String(describing: LabelViewController.self)
        case .picker:
            return String(describing: PickerViewController.self)
        }
    }
    
}

import Foundation
