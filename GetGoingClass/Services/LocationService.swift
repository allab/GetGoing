//
//  LocationService.swift
//  GetGoingClass
//
//  Created by Alla Bondarenko on 2019-01-30.
//  Copyright © 2019 SMU. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject {

    // singleton
    static let shared = LocationService()

    // MARK: - Properties

    var locationManager: CLLocationManager?
    weak var delegate: LocationServiceDelegate?

    private override init() {
        super.init()

        locationManager = CLLocationManager()

        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager?.requestWhenInUseAuthorization()
        }
        locationManager?.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager?.delegate = self
    }

    // MARK: - Location Manager

    func startUpdatingLocation() {
        locationManager?.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        locationManager?.stopUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        delegate?.didUpdateLocation(location: location)
    }
}

// Custom protocol
protocol LocationServiceDelegate: class {
    func didUpdateLocation(location: CLLocation)
}

