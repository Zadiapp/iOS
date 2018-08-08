//
//  ZADDefaults.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 8/1/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit
import MapKit

class ZADDefaults: NSObject {
    static let sharedInstance = ZADDefaults()
    
    var applicationLanguage:Langugage? {
        set {
            UserDefaults.standard.set(newValue?.rawValue, forKey: "APPLICATION_LANGUAGE")
            if let lang = newValue {
                ZADStrings.sharedInstance.changeLangugage(lang: lang)
            }
            UserDefaults.standard.synchronize()
        }
        
        get {
            let userDefaultValue = UserDefaults.standard.value(forKey: "APPLICATION_LANGUAGE")
            if let langugage = userDefaultValue {
                if let langugage = Langugage(rawValue: langugage as! String) {
                    return langugage
                }
            }
            
             return .notSet
        }
    }
    
    var userLocation:CLLocationCoordinate2D? {
        set {
            if let location = newValue {
                let lat = NSNumber(value: location.latitude)
                let long = NSNumber(value: location.longitude)
                let userLocationDict = ["lat":lat, "long":long];
                
                UserDefaults.standard.set(userLocationDict, forKey: "USER_LOCATION")
            } else {
                UserDefaults.standard.removeObject(forKey: "USER_LOCATION")
            }
            
            UserDefaults.standard.synchronize()
        }
        
        get {
            let userDefaultValue = UserDefaults.standard.value(forKey: "USER_LOCATION")
            if let locationDict = userDefaultValue as? [String:NSNumber] {
                let lat = locationDict["lat"]?.doubleValue
                let long = locationDict["long"]?.doubleValue
                if let latitude = lat , let longitude = long {
                    return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                }
            }

            return self.userLocation
        }
    }
    
    var isRegistedRequiredData:Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "IS_REGISTERD_REQUIRED_DATA")
            UserDefaults.standard.synchronize()
        }
        
        get {
            let userDefaultValue = UserDefaults.standard.bool(forKey: "IS_REGISTERD_REQUIRED_DATA")
            return userDefaultValue
        }
    }
}
