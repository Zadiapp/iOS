//
//  ZADNearByRequets.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 8/11/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit

class ZADNearByRequets: NSObject {
    
}

extension ZADNearByRequets: ZADRequest {
    var path: String {get {return "markets/nearby"}}
    var method: HTTPMethod {get {return .get}}
    var parameters: RequestParams {get {
        return .url([:])
        }}
    var headers: [String : Any]? {get { return ["Authorization" : "BearereyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjMsImlzcyI6Imh0dHA6Ly8zNS4xOTkuMTU5LjIxOC9hcGkvcmVnaXN0ZXItZ3Vlc3QiLCJpYXQiOjE1MzI3NzkxNTIsImV4cCI6MTUzMzk4ODc1MiwibmJmIjoxNTMyNzc5MTUyLCJqdGkiOiJhakJwQ29QWVdNVzZ2bjhJIn0.TcN1ADY_pMaRzfr3ZJXeUUYI5QvfcXHkR_L22GHzk9A"]}}
    var dataType: DataType {get {return .JSON}}
}
