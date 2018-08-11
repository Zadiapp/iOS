//
//  ZADNearByRequests.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 8/11/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit

class ZADNearByRequests: NSObject {

}

extension ZADNearByRequests: ZADOperation {
    typealias Output = [ZADMarkets]
    
    var request: ZADRequest { get {return ZADNearByRequets()}}
    
    func execute(dispatcher: ZADDispatcher, completionHandler: ([ZADMarkets]) -> ()) {
        do {
            try dispatcher.execute(request: self.request, compeltionHandler: { (response) in
                
            })
        } catch {
            
        }
    }
}
