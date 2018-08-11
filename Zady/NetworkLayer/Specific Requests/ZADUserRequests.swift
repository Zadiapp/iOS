//
//  ZADUserRequests.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 8/11/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit

class ZADUserRequests: NSObject {

    var params:[String:Any] = [:]
    
    init(params:[String:Any]) {
        super.init()
        
        self.params = params
    }
    
}

extension ZADUserRequests: ZADRequest {
    var path: String {get {return "register-guest"}}
    var method: HTTPMethod {get {return .post}}
    var parameters: RequestParams {get {
       return .body(self.params)
        }}
    var headers: [String : Any]? {get { return [:]}}
    var dataType: DataType {get {return .JSON}}
}
