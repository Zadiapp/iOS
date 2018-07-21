//
//  ZADResponse.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/21/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum ZADResponse {
    case json(_: JSON)
    case data(_: Data)
    case error(_: Int?, _: Error?)
    
    init(data:Data? ,response:HTTPURLResponse?, error:Error?, request:ZADRequest) {
        guard response?.statusCode == 200, error == nil else {
            self = .error(response?.statusCode, error)
            return
        }
        
        guard let data = data else {
            self = .error(response?.statusCode, ZADNetworkErrors.noData)
            return
        }
        
        switch request.dataType {
        case .Data:
            self = .data(data)
        case .JSON:
            do {
                let json = try JSON(data: data)
                self = .json(json)
            } catch {
                self = .error(response?.statusCode, ZADNetworkErrors.badInput)
                return
            }
        }
    }
}
