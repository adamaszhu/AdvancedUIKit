/**
 * DeviceInfoAccessor is used to access info related to the device.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 29/05/2017
 */
public class DeviceInfoAccessor {
    
    /**
     * The singleton instance in the system.
     */
    public static let shared: DeviceInfoAccessor = DeviceInfoAccessor()
    
    /**
     * The system version of the device.
     */
    public var systemVersion: String {
        return device.systemVersion
    }
    
    /**
     * The major system version.
     */
    public var majorSystemVersion: Int {
        return processInfo.operatingSystemVersion.majorVersion
    }
    
    /**
     * The type of the device.
     */
    public var deviceType: DeviceType {
        let deviceModel = device.model
        if deviceModel.contains(DeviceType.phone.rawValue) {
            return .phone
        }
        if deviceModel.contains(DeviceType.pad.rawValue) {
            return .pad
        }
        if deviceModel.contains(DeviceType.watch.rawValue) {
            return .watch
        }
        return .unknown
    }
    
    /**
     * The width of the device screen.
     */
    public var screenWidth: CGFloat {
        return screen.bounds.width
    }
    
    /**
     * The height of the device screen.
     */
    public var screenHeight: CGFloat {
        return screen.bounds.height
    }
    
    /**
     * The device.
     */
    private let device: UIDevice
    
    /**
     * The process information.
     */
    private let processInfo: ProcessInfo
    
    /**
     * The screen of the device.
     */
    private let screen: UIScreen
    
    /**
     * Initialize the object.
     * - parameter device: The device object.
     * - parameter screen: The device screen.
     * - parameter processInfo: The information of the process.
     */
    init(device: UIDevice = UIDevice.current, processInfo: ProcessInfo = ProcessInfo(), screen: UIScreen = UIScreen.main) {
        self.device = device
        self.processInfo = processInfo
        self.screen = screen
    }
    
}

import UIKit
