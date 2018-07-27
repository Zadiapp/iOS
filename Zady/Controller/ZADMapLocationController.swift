//
//  ZADMapLocationController.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/27/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit
import MapKit

class ZADMapLocationController: NSObject {
    var locationManager:ZADLocationManager?
    
    override init() {
        super.init()
        setupLocation()
    }
    
    func setupLocation() {
        locationManager = ZADLocationManager()
        if let locationManager = locationManager {
            locationManager.delegate = self
            locationManager.requestLocation()
        }
    }
    
    func searchLocationWith(keyword:String, region:MKCoordinateRegion, compeltionHandler:@escaping ([MKMapItem])->()) {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = keyword
        request.region = region
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else {
                return
            }
            
            let matchingItems = response.mapItems
            compeltionHandler(matchingItems)
        }
    }
}

extension ZADMapLocationController: ZADLocationManagerProtocol {
    func didlocationUpdated(location: CLLocation) {
        
    }
    
    func didAcquireLocation(acuireLocation: Bool) {
        
    }
}


