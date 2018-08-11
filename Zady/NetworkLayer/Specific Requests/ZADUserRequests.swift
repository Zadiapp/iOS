//
//  ZADUserRequests.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 8/11/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit
import CoreLocation

class ZADUserRequests: NSObject {

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

extension ZADUserRequests: ZADRequest {
    var path: String {get {return "/register-guest"}}
    var method: HTTPMethod {get {return .post}}
    var parameters: RequestParams {get {
       return .body(self.getParams())
        
        }}
    var headers: [String : Any]? {get { return ["Content-Type":"application/json"]}}
    var dataType: DataType {get {return .JSON}}
}
