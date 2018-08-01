//
//  ZADLocationManager.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/16/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit
import CoreLocation

protocol ZADLocationManagerProtocol {
    func didAcquireLocation(acuireLocation:Bool);
    func didlocationUpdated(location:CLLocation);
}

class ZADLocationManager: NSObject {
    var delegate:ZADLocationManagerProtocol?
    
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestLocation () {
        locationManager.requestLocation()
    }
    
    static func isLocationAuthorized() -> Bool {
        return (CLLocationManager.authorizationStatus() == .authorizedWhenInUse)
    }
    
    static func isLocationCancled() -> Bool {
        return (CLLocationManager.authorizationStatus() == .denied)
    }
}

extension ZADLocationManager:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if let delegate = self.delegate {
            if status != .notDetermined {
                delegate.didAcquireLocation(acuireLocation: (status == .authorizedWhenInUse))
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            if let delegate = self.delegate {
                delegate.didlocationUpdated(location: location)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
}
