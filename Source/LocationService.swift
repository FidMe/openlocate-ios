//
//  LocationService.swift
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

import Foundation
import CoreLocation

protocol LocationServiceType {
    var transmissionInterval: TimeInterval { get set }
    
    var isStarted: Bool { get }
    
    func start()
    func stop()
}

private let locationsKey = "locations"

final class LocationService: LocationServiceType {
    
    let IsStartedKey = "OpenLocate_isStarted"
    
    var transmissionInterval: TimeInterval
    
    var isStarted: Bool {
        return UserDefaults.standard.bool(forKey: IsStartedKey)
    }

    private let locationManager: LocationManagerType
    private let httpClient: Postable
    private let locationDataSource: LocationDataSourceType
    private var advertisingInfo: AdvertisingInfo

    private var url: String
    private var headers: Headers?
    
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid

    init(
        postable: Postable,
        locationDataSource: LocationDataSourceType,
        url: String,
        headers: Headers?,
        advertisingInfo: AdvertisingInfo,
        locationManager: LocationManagerType,
        transmissionInterval: TimeInterval) {

        httpClient = postable
        self.locationDataSource = locationDataSource
        self.locationManager = locationManager
        self.advertisingInfo = advertisingInfo
        self.url = url
        self.headers = headers
        self.transmissionInterval = transmissionInterval
    }

    func start() {
        debugPrint("Location service started for url : \(url)")

        locationManager.subscribe { locations in
            
            let openLocateLocations = locations.map {
                return OpenLocateLocation(location: $0, advertisingInfo: self.advertisingInfo)
            }
            
            self.locationDataSource.addAll(locations: openLocateLocations)
            
            debugPrint(self.locationDataSource.count)
            
            self.postAllLocationsIfNeeded()
        }
        
        UserDefaults.standard.set(true, forKey: IsStartedKey)
    }

    func stop() {
        locationManager.cancel()
        UserDefaults.standard.set(false, forKey: IsStartedKey)
        postAllLocations()
    }
    
}

extension LocationService {
    
    private func postAllLocationsIfNeeded() {
        if let earliestIndexedLocation = locationDataSource.first() {
            let earliestLocation = OpenLocateLocation(data: earliestIndexedLocation.1.data)
            if abs(earliestLocation.location.timestamp.timeIntervalSinceNow) > self.transmissionInterval {
                postAllLocations()
            }
        }
    }
    
    private func postAllLocations() {
        let indexedLocations = locationDataSource.all()
        if indexedLocations.isEmpty == false {
            locationDataSource.clear()
            let locations = indexedLocations.map { $1 }
            self.postLocations(locations: locations)
        }
    }

    private func postLocations(locations: [OpenLocateLocationType]) {
        
        if locations.isEmpty {
            return
        }

        let params = [locationsKey: locations.map { $0.json }]
        
        beginBackgroundTask()
        
        do {
            try httpClient.post(
                params: params,
                queryParams: nil,
                url: url,
                additionalHeaders: headers,
                success: {  [weak self] _, _ in
                    self?.endBackgroundTask()
            }
            ) {  [weak self] _, _ in
                debugPrint("failure in posting locations!!!")
                self?.locationDataSource.addAll(locations: locations)
                self?.endBackgroundTask()
            }
        } catch let error {
            print(error.localizedDescription)
            endBackgroundTask()
        }
    }
    
    func beginBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
    }
    
    func endBackgroundTask() {
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = UIBackgroundTaskInvalid
    }
    
    static func isAuthorizationKeysValid() -> Bool {
        let always = Bundle.main.object(forInfoDictionaryKey: "NSLocationAlwaysUsageDescription")
        let inUse = Bundle.main.object(forInfoDictionaryKey: "NSLocationWhenInUseUsageDescription")
        let alwaysAndinUse = Bundle.main.object(forInfoDictionaryKey: "NSLocationAlwaysAndWhenInUseUsageDescription")
        return always != nil || inUse != nil || alwaysAndinUse != nil
    }
}
