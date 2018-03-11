//
//  LocationService.swift
//  Weather
//
//  Created by George on 2018/03/09.
//  Copyright © 2018 george kapoya. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation



protocol LocationProtocol {
    func locationDidUpdate(_ service: LocationService, location : CLLocation)
}


class LocationService: NSObject {
    var delegate: LocationProtocol?
    
   private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
       
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
      
    }
    
    func requestLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
}

extension LocationService : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            delegate?.locationDidUpdate(self, location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error finding location: \(error.localizedDescription)")
    }
}

