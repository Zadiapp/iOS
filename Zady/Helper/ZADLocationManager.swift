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
}

class ZADLocationManager: NSObject {
    static let sharedInstance = ZADLocationManager()
    var delegate:ZADLocationManagerProtocol?
    
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        
        locationManager.delegate = self
    }
    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func isLocationAuthorized() -> Bool {
        return (CLLocationManager.authorizationStatus() == .authorizedWhenInUse)
    }
}

extension ZADLocationManager:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if let delegate = self.delegate {
            delegate.didAcquireLocation(acuireLocation: (status == .authorizedWhenInUse))
        }
    }
}
