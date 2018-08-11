//
//  ZADRegisterTask.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 8/11/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit
import CoreLocation
class ZADRegisterTask: NSObject {
    var language:String?
    var deviceId:String?
    var token:String?
    var coordinate:CLLocationCoordinate2D?
    
    init(lang:String, deviceId:String, token:String?, coordinate:CLLocationCoordinate2D) {
        super.init()
        
        self.language = lang
        self.deviceId = deviceId
        self.token = token
        self.coordinate = coordinate
    }
    
    func getParams() -> [String: Any] {
        var params:[String:Any] = [:]
        
        if let lang = self.language {
            params["language"] = lang
        }
        
        if let deviceId = self.deviceId {
            params["device_id"] = deviceId
        }
        
        if let token = self.token {
            params["token"] = token
        }
        
        if let coordinate = self.coordinate {
            params["latitude"] = coordinate.latitude
            params["longitude"] = coordinate.longitude
        }
        
        return params
    }
}

extension ZADRegisterTask: ZADOperation {
    typealias Output = ZADUser
    var request: ZADRequest { get {return ZADUserRequests(params: self.getParams())}}
    
    func execute(dispatcher: ZADDispatcher, completionHandler: (ZADUser) -> ()) {
        do {
            try dispatcher.execute(request: self.request, compeltionHandler: { (response) in
                
            })
        } catch {
            
        }
    }
}
