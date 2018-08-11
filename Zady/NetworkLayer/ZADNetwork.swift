//
//  ZADNetwork.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 8/11/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit

class ZADNetwork: NSObject {
    static func getDispatcher() -> ZADNetworkDispatcher {
        var enviroment: ZADEnvironment = ZADEnvironment("Debugging", host: "http://35.199.159.218/api")
        enviroment.headers = ["Content-Type":"application/json"]
        let dispatcher:ZADNetworkDispatcher = ZADNetworkDispatcher(environment: enviroment)
        
        return dispatcher
    }
}
