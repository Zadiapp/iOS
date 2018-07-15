//
//  ZADLocationManager.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/16/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit
import CoreLocation

class ZADLocationManager: NSObject {
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        
        locationManager.delegate = self
    }
    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
}

extension ZADLocationManager:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}
