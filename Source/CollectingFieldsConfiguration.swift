//
//  CollectingFieldsConfiguration.swift
//
//  Copyright (c) 2017 OpenLocate
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

/// Describes which data is sending from the device
@objc
public final class CollectingFieldsConfiguration: NSObject {
    /// Determines whether network information is sending or not. Default value is true.
    @objc public let shouldLogNetworkInfo: Bool

    /// Determines whether device course (bearing) is sending or not. Default value is true.
    @objc public let shouldLogDeviceCourse: Bool

    /// Determines whether device speed is sending or not. Default value is true.
    @objc public let shouldLogDeviceSpeed: Bool

    /// Determines whether device charging status should be sent ot not. Default value is true.
    @objc public let shouldLogDeviceCharging: Bool

    /// Determines whether device model should be sent. Default value is true.
    @objc public let shouldLogDeviceModel: Bool

    /// Determines whether device's os version is sent. Default value is true.
    @objc public let shouldLogDeviceOsVersion: Bool

    /// Determines whether device's location permission is sent. Default value is true.
    @objc public let shouldLogDeviceLocationPermission: Bool
    
    /// Determines whether device's location coordinates will be sent. Default value is true.
    @objc public let shouldLogLocation: Bool

    /// Determines whether timestamp of the recorded location in epoch will be sent. Default value is true.
    @objc public let shouldLogTimestamp: Bool

    /// Determines whether accuracy of the location will be sent. Default value is true.
    @objc public let shouldLogHorizontalAccuracy: Bool

    /// Determines whether altitude accuracy will be sent. Default value is true.
    @objc public let shouldLogVerticalAccuracy: Bool

    /// Determines whether altitude will be sent. Default value is true.
    @objc public let shouldLogAltitude: Bool

    /// Determines whether 'idfa' for identifying Apple device advertising type will be sent. Default value is true.
    @objc public let shouldLogAdId: Bool

    /// Default configuration. All parameters are set to true.
    @objc public static let `default` = CollectingFieldsConfiguration(
        shouldLogNetworkInfo: true,
        shouldLogDeviceCourse: true,
        shouldLogDeviceSpeed: true,
        shouldLogDeviceCharging: true,
        shouldLogDeviceModel: true,
        shouldLogDeviceOsVersion: true,
        shouldLogDeviceLocationPermission: true,
        shouldLogLocation: true,
        shouldLogTimestamp: true,
        shouldLogHorizontalAccuracy: true,
        shouldLogVerticalAccuracy: true,
        shouldLogAltitude: true,
        shouldLogAdId: true
    )
    
    @objc
    public init(shouldLogNetworkInfo: Bool,
                shouldLogDeviceCourse: Bool,
                shouldLogDeviceSpeed: Bool,
                shouldLogDeviceCharging: Bool,
                shouldLogDeviceModel: Bool,
                shouldLogDeviceOsVersion: Bool,
                shouldLogDeviceLocationPermission: Bool,
                shouldLogLocation: Bool,
                shouldLogTimestamp: Bool,
                shouldLogHorizontalAccuracy: Bool,
                shouldLogVerticalAccuracy: Bool,
                shouldLogAltitude: Bool,
                shouldLogAdId: Bool) {

        self.shouldLogNetworkInfo = shouldLogNetworkInfo
        self.shouldLogDeviceCourse = shouldLogDeviceCourse
        self.shouldLogDeviceSpeed = shouldLogDeviceSpeed
        self.shouldLogDeviceCharging = shouldLogDeviceCharging
        self.shouldLogDeviceModel = shouldLogDeviceModel
        self.shouldLogDeviceOsVersion = shouldLogDeviceOsVersion
        self.shouldLogDeviceLocationPermission = shouldLogDeviceLocationPermission
        self.shouldLogLocation = shouldLogLocation
        self.shouldLogTimestamp = shouldLogTimestamp
        self.shouldLogHorizontalAccuracy = shouldLogHorizontalAccuracy
        self.shouldLogVerticalAccuracy = shouldLogVerticalAccuracy
        self.shouldLogAltitude = shouldLogAltitude
        self.shouldLogAdId = shouldLogAdId
    }
}
