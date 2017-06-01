enum Feature: String {
    
    case device = "Device"
    case label = "Label"
    case picker = "Picker"
    case message = "Message"
    
    var viewControllerID: String {
        switch self {
        case .device:
            return String(describing: DeviceViewController.self)
        case .label:
            return String(describing: LabelViewController.self)
        case .picker:
            return String(describing: PickerViewController.self)
        case .message:
            return String(describing: MessageViewController.self)
        }
    }
    
}

import Foundation
